---
name: sp-plan-discovery
description: Use before any brainstorming or planning session when the idea needs interrogation first. Conducts a relentless one-question-at-a-time interview to surface assumptions, constraints, risks, and open decisions before any design work begins. Triggers on "I want to build X", "help me plan Y", "I need to think through Z".
---

# sp-plan-discovery

An interrogation-first layer that runs before brainstorming or planning. Its job is to surface what is unknown, assumed, or contradictory — so that brainstorming starts from clarity, not fog.

## How to Run This

Interview the user relentlessly about every aspect of the idea until you reach a shared understanding. Walk down each branch of the decision tree, resolving dependencies one by one.

**Rules:**
- Ask questions one at a time. No lists.
- For each question, provide your recommended answer with reasoning.
- If the answer can be inferred from the codebase, files, or conversation — explore those first. Do not ask for what you can already find.
- Press each answer: ask why, challenge the assumption behind it, explore the alternative path.
- When a fork appears (option A vs B), work through it before moving to the next topic.
- Surface and name hidden assumptions the moment you detect them.
- Maintain the language of the current conversation throughout. Do not switch languages unless the user explicitly asks.
- Do not rush toward brainstorming. Discovery is done when the idea has no significant unexplored forks.

## What to Explore

Work through these areas in natural conversation order — not as a rigid checklist:

- **Real problem**: What problem is actually being solved? Is the stated solution the right lever?
- **Actors**: Who uses this? What do they need vs. what they say they need?
- **Constraints**: Tech stack, timeline, team, existing systems — what can't move?
- **Assumptions**: What is being taken for granted? Surface and challenge at least 3.
- **Risks**: What could make this fail?
- **Dependencies**: What does this block on internally or externally?
- **Open decisions**: What has not been decided yet?
- **Scope**: What is explicitly out of scope?

## Handoff

When the idea is sufficiently understood, produce a brief context block summarizing:
- Problem confirmed
- Key constraints
- Assumptions surfaced (and challenged)
- Open decisions resolved
- Risks identified
- Scope boundaries

Then hand off to your brainstorming workflow (e.g., `superpowers:brainstorming` on Claude Code) with the full context, so it doesn't need to re-ask what was already resolved here.
