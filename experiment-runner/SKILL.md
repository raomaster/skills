---
name: experiment-runner
description: Use when executing an iterative experimentation loop — reads program.md, creates a session branch, proposes changes to a target file, measures results, and commits only improvements that pass a consistency check. Can be used standalone or via autoresearch.
---

# experiment-runner

Execution engine for iterative experimentation. Creates a clean session branch, loops through experiments, commits only what works.

## Prerequisites

Before starting:
- `program.md` exists in the project directory (use `autoresearch` to create it)
- `scripts/measure.sh` is adapted to your domain (must return a single numeric value to stdout)
- Git repo has a clean working tree (`git status` shows nothing to commit)

## Session Setup

```bash
./scripts/create-session-branch.sh
# Creates: autoresearch/session-YYYY-MM-DD
# Main branch is never touched during the loop
```

Verify:
```bash
git branch --show-current
# Expected: autoresearch/session-YYYY-MM-DD
```

## One Iteration (repeat until stop condition)

1. **Read `program.md`** — understand current hypothesis and constraints
2. **Propose one change** to the target file — smallest coherent modification
3. **Measure**: run `scripts/measure.sh`, capture numeric output
4. **Compare** result vs current baseline:

**If result > baseline:**
- Run the full consistency suite (e.g., `npm test`, `pytest`, `make test`)
- **If passes:** commit to session branch + update baseline in `experiments.md`
- **If fails:** `git checkout . && git clean -fd` → log as POSITIVE-INCONSISTENT

**If result <= baseline:**
- `git checkout . && git clean -fd`
- Log as DISCARDED

## experiments.md Log Format

Maintain `experiments.md` in the project directory. Append one entry per iteration:

```markdown
## Iteration N — YYYY-MM-DD HH:MM

**Change:** [one-line description of what was modified]
**Result:** [numeric metric value]
**Baseline at time:** [baseline value before this iteration]
**Delta:** [result - baseline, with sign]
**Outcome:** KEPT / DISCARDED / POSITIVE-INCONSISTENT
**Commit:** [short hash if KEPT, — otherwise]
**Notes:** [optional — why consistency failed, what was surprising]
```

## Stop Conditions

Stop the loop when any of these are true:
- Metric reaches the target defined in `program.md`
- Max iterations reached
- **5 consecutive DISCARDED results** → pause, report to user, ask: continue / change strategy / stop

## After the Session

The session branch contains only successful + consistent commits. Give the user these options:

```bash
# Option A: Squash all experiments into one commit on main
git checkout main
git merge --squash autoresearch/session-YYYY-MM-DD
git commit -m "feat: autoresearch improvements [N experiments, +X metric]"

# Option B: Cherry-pick specific experiments
git cherry-pick <hash1> <hash2>

# Option C: Discard everything
git branch -D autoresearch/session-YYYY-MM-DD
```
