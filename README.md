# raomaster/skills

Personal cross-platform agent skills — installable via the [agentskills.io](https://agentskills.io) standard.

Works with: Claude Code, OpenCode, Codex, GitHub Copilot, Cursor, and any agent that supports SKILL.md.

## Skills

### sp-plan-discovery

Pre-plan interrogation layer. Conducts a grill-me style interview — one relentless question at a time — to surface assumptions, constraints, risks, and open decisions before any design work begins.

```bash
npx skills@latest add raomaster/skills/sp-plan-discovery
```

---

### playwright-browser

Reference guide for browser automation with Playwright: navigation, clicks, form fills, screenshots, assertions, and network interception. Includes common patterns and gotchas.

```bash
npx skills@latest add raomaster/skills/playwright-browser
```

---

### skill-creator

Lean cross-platform workflow for authoring agent skills. Captures intent, interviews the user, writes SKILL.md with valid agentskills.io frontmatter, and proposes manual test scenarios.

```bash
npx skills@latest add raomaster/skills/skill-creator
```

---

### save-knowledge

Routes decisions and discoveries to the right knowledge source: `kb` command if available, otherwise creates a markdown file in `docs/decisions/`.

```bash
npx skills@latest add raomaster/skills/save-knowledge
```

---

### autoresearch

Orchestrates autonomous experimentation sessions (Karpathy-style ratchet loop). Guides you through defining target, metric, and budget — then delegates execution to `experiment-runner`.

```bash
npx skills@latest add raomaster/skills/autoresearch
```

---

### experiment-runner

Execution engine for iterative experimentation loops. Creates a session branch, proposes changes, measures results, and commits only improvements that pass consistency checks. Reusable beyond autoresearch.

```bash
npx skills@latest add raomaster/skills/experiment-runner
```

---

### chrome-devtools

Complement to the official [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) plugin. Covers privacy-first setup (`--no-usage-statistics`), per-project context management (on/off), when to use this MCP vs Playwright, and ethical hacking patterns (Burp proxy, recon, endpoint mapping).

**Install skill:**
```bash
npx skills@latest add raomaster/skills/chrome-devtools
```

**Setup MCP in current project (local scope, no tracking):**
```sh
# 1. Install official plugin (MCP + official skills) — restart Claude Code after
/plugin marketplace add ChromeDevTools/chrome-devtools-mcp
/plugin install chrome-devtools-mcp

# 2. Add MCP scoped to this project
claude mcp add chrome-devtools --scope local -- npx -y chrome-devtools-mcp@latest --no-usage-statistics
```

---

## Install all skills at once

```bash
npx skills@latest add raomaster/skills/sp-plan-discovery
npx skills@latest add raomaster/skills/playwright-browser
npx skills@latest add raomaster/skills/skill-creator
npx skills@latest add raomaster/skills/save-knowledge
npx skills@latest add raomaster/skills/autoresearch
npx skills@latest add raomaster/skills/experiment-runner
npx skills@latest add raomaster/skills/chrome-devtools
```

---

## Related projects

### [agent-security-policies](https://github.com/raomaster/agent-security-policies)

Security skills and policies for AI agents (OWASP ASVS, CWE/SANS Top 25, NIST). Includes: `sast-scan`, `secrets-scan`, `dependency-scan`, `container-scan`, `iac-scan`, `threat-model`, `fix-findings`, `security-review`.

```bash
npx agent-security-policies --agent claude --skills
```

### [superpowers](https://github.com/anthropics/claude-code) (Claude Code plugin)

The `sp-plan-discovery` skill is designed to feed into `superpowers:brainstorming` on Claude Code.

---

## Standard

Skills follow the [agentskills.io specification](https://agentskills.io/specification). Structural reference: [mattpocock/skills](https://github.com/mattpocock/skills).

## License

MIT — see [LICENSE](LICENSE).
