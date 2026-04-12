---
name: autoresearch
description: Use when setting up or running iterative autonomous experimentation — define a target file, success metric, and iteration budget, then let the agent loop through changes and keep only improvements. Inspired by Karpathy's autoresearch ratchet loop pattern.
---

# autoresearch

Orchestrate an autonomous experimentation session. You define the goal and metric; the loop does the rest.

## Step 1 — Define Parameters

Answer these four questions with the user before writing anything:

1. **Target file** — What single file will the agent modify each iteration?
   (e.g., `src/model.py`, `config/prompt.txt`, `src/algorithm.js`)
2. **Success metric** — How is improvement measured? Must return a single numeric value.
   (e.g., accuracy %, test pass count, latency ms, benchmark score)
3. **Time budget** — How long is one experiment allowed to run?
   (e.g., 30s, 5min, 30min)
4. **Max iterations** — Total attempts before stopping.
   (e.g., 20, 50, 100)

## Step 2 — Write program.md

Create `program.md` in the project root. This is the instruction file the loop executes each iteration:

```markdown
# Experiment Program

**Target:** path/to/target/file
**Metric:** [description of what to measure — must produce a single number]
**Baseline:** [current metric value before any changes — measure this first]
**Time per experiment:** Xs / Xmin
**Max iterations:** N
**Stop condition:** metric > X, or max iterations reached

## Hypothesis Space
[Ordered list of approaches to try — agent works through these in priority order]
1. [Most promising approach]
2. [Second approach]
3. [Third approach]

## Constraints
[What must NOT change across experiments]
- Do not modify test files
- API surface must remain backward compatible
- [Add domain-specific constraints]
```

Measure the baseline BEFORE starting the loop. Record it in `program.md`.

## Step 3 — Delegate to experiment-runner

Once `program.md` is approved by the user, hand off to `experiment-runner` to execute the loop.

Provide `experiment-runner` with:
- Path to `program.md`
- Path to `scripts/measure.sh` (the metric script — must be adapted for this domain)
- Confirmation that the git working tree is clean

## Step 4 — Summarize Results

After the loop ends, read `experiments.md` and summarize:
- Total iterations run
- Experiments kept (metric delta per experiment, commit hash)
- Experiments marked "positive but inconsistent" (why consistency failed)
- Final baseline vs initial baseline (total improvement)
- Recommended next steps
