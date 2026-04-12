---
name: skill-creator
description: Use when creating a new agent skill file — captures intent, interviews about behavior and edge cases, writes SKILL.md with valid agentskills.io frontmatter, and proposes manual test scenarios. Works for any agent following the agentskills.io standard.
---

# skill-creator

A lean, cross-platform workflow for authoring agent skills. No automated evals — cycle is draft → manual test → refine.

## Process

1. **Capture intent** — Ask: What should this skill help an agent do? What triggers it?
2. **Interview** — One question at a time:
   - What does the agent get wrong without this skill?
   - What are 2–3 concrete scenarios where this skill applies?
   - What are the hard rules the agent must follow?
   - What are the most common mistakes to avoid?
3. **Write SKILL.md** — Using the structure below.
4. **Propose test cases** — Write 2–3 manual pressure scenarios.
5. **Iterate** — User tests scenarios, reports gaps, refine.

## SKILL.md Structure

```markdown
---
name: skill-name-with-hyphens
description: Use when [specific triggering conditions — NOT a workflow summary]
---

# Skill Name

## When to Use
[Symptoms and contexts. When NOT to use.]

## Core Rules
[Constraints or technique — numbered if sequential, bullets if parallel]

## Common Mistakes
[What goes wrong + how to fix it]
```

## Frontmatter Rules

- `name`: letters, numbers, hyphens only — no parentheses or special chars
- Total frontmatter: under 1024 characters
- `description`: triggering conditions ONLY — never summarize the workflow
  - Start with "Use when..."
  - Keep under 500 characters

**Bad description** (summarizes workflow — agent may follow this instead of reading skill body):
> "Use when planning — asks questions one at a time, proposes 3 approaches, then gets approval"

**Good description** (triggering conditions only):
> "Use when starting any design or planning work before writing code"

## Test Case Template

For each scenario, define:

1. **Context**: What is the conversation about?
2. **Pressure**: What makes the agent want to skip the skill?
3. **Pass condition**: What does correct behavior look like?
4. **Fail condition**: What specific violation are you watching for?

Run each scenario manually with an agent. Report what the agent did wrong — refine the skill to address that exact rationalization.
