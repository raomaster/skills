---
name: save-knowledge
description: "Use when a decision, discovery, plan outcome, or important finding needs to be saved for future reference. Routes to kb inbox (if available) AND appends to episodic memory for kb-dream. Falls back to docs/decisions/ when kb is not installed."
---

# save-knowledge

Save decisions and discoveries to the right place, automatically.

## Priority Order

1. **If `kb` command exists** → `kb "<structured content>"` (sends text directly to inbox as a timestamped `.md` file)
2. **Else** → create `docs/decisions/YYYY-MM-DD-<title>.md` in the current project directory

**IMPORTANT — `kb` CLI usage:**
- `kb "text"` → saves text to inbox (CORRECT for saving knowledge)
- `kb add <file>` → copies an existing FILE to inbox (only for files, NOT text)
- NEVER use `kb add "text"` — it will fail with "file not found"

## Two Save Targets

When `kb` is available, every save goes to **two places**:

### 1. Inbox (for classification by `kb process`)
```bash
kb "Title: <descriptive title>

Decision: [what was decided]
Why: [the reason]
Context: [project, component]"
```

### 2. Episodic Memory (for consolidation by `kb-dream`)
Append claims to `$KB_VAULT/memory/YYYY-MM-DD.md`. This file accumulates
claims throughout the day. `kb-dream` reads these to build MEMORY.md and
promote high-confidence findings to `raw/memory-derived/`.

```bash
# Append to today's memory file — create if it doesn't exist
MEMORY_FILE="$KB_VAULT/memory/$(date +%Y-%m-%d).md"
```

Each claim uses this YAML format:
```yaml
- claim: "Short factual statement of what was decided or discovered"
  memory_type: decision | technical-finding | user-preference | user-rule
  confidence: low | medium | high
  context: "Project or area this relates to"
```

**memory_type guide:**
| Type | When to use | Example |
|------|-------------|---------|
| `decision` | A choice between alternatives was made | "Chose Regional LB over Global LB for webhook traffic" |
| `technical-finding` | Something non-obvious was discovered or validated | "Cloud Armor policy is active on the LB backend service" |
| `user-preference` | User expressed a preference for how things should work | "User wants gemini-3-flash-preview only" |
| `user-rule` | User set a rule that must always be followed | "Never log webhook payloads" |

**confidence guide:**
| Level | Criteria |
|-------|----------|
| `high` | Verified by evidence (logs, config, tests, user confirmation) |
| `medium` | Reasonable inference from available data |
| `low` | Speculation or unverified assumption |

### Workflow

When saving knowledge with `kb` available:

1. Send structured content to inbox: `kb "Title: ..."`
2. Append claim(s) to `$KB_VAULT/memory/$(date +%Y-%m-%d).md`
3. Both happen every time — never skip memory

When `kb` is NOT available:
1. Create `docs/decisions/YYYY-MM-DD-<title>.md` in the current project
2. Memory is not written (no vault access)

## What to Save

Save when you encounter:
- A decision between multiple approaches (what was chosen and why)
- A discovery that wasn't obvious from the code or docs
- A constraint that will affect future work
- The outcome of an experiment or investigation

## What to Include

Structure every save with a clear title line followed by structured content.
The content will be processed later by `kb process` which classifies and archives it.

## Markdown Fallback Format

When `kb` is NOT available, create `docs/decisions/YYYY-MM-DD-<title>.md`:

```markdown
# [Title]

**Date:** YYYY-MM-DD

## Decision
[What was decided]

## Why
[Rationale and constraints]

## Alternatives Discarded
- [Option A]: [why rejected]
- [Option B]: [why rejected]
```
