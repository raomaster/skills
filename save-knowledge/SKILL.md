---
name: save-knowledge
description: "Use when a decision, discovery, plan outcome, or important finding needs to be saved for future reference. Routes automatically to the available knowledge source: kb command if present, otherwise creates a markdown file in docs/decisions/."
---

# save-knowledge

Save decisions and discoveries to the right place, automatically.

## Priority Order

1. **If `kb` command exists** → `kb add "<title>: <content>"`
2. **Else** → create `docs/decisions/YYYY-MM-DD-<title>.md` in the current project directory

Use `scripts/save.sh` to detect availability and route automatically.

## What to Save

Save when you encounter:
- A decision between multiple approaches (what was chosen and why)
- A discovery that wasn't obvious from the code or docs
- A constraint that will affect future work
- The outcome of an experiment or investigation

## What to Include

Structure every save as:

```
Decision: [what was decided]
Why: [the reason, including constraints that drove it]
Discarded: [alternatives considered and why they were rejected]
```

## Markdown Fallback Format

When saving to `docs/decisions/YYYY-MM-DD-<title>.md`:

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
