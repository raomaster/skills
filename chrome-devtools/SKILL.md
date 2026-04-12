---
name: chrome-devtools
description: Use when setting up or using the Chrome DevTools MCP — covers privacy-first install (--no-usage-statistics), per-project scoping to avoid polluting global context, when to use this MCP instead of Playwright, and ethical hacking patterns (Burp proxy, session recon, endpoint mapping).
---

# chrome-devtools

Complement to the official `ChromeDevTools/chrome-devtools-mcp` plugin. Install the plugin first — it covers core automation, performance, and debugging. This skill covers what the plugin doesn't: privacy, context management, and ethical hacking.

## Setup

See README for copy-paste install blocks. Run `scripts/setup-local.sh` to add the MCP to the current project.

## Managing Context (On/Off)

The MCP loads 29 tools into context. Add per project, remove when done:

```bash
# Add to current project
claude mcp add chrome-devtools --scope local -- npx -y chrome-devtools-mcp@latest --no-usage-statistics

# Remove
claude mcp remove chrome-devtools

# Verify
claude mcp list
```

Use `--slim` (3 tools: `navigate_page`, `evaluate_script`, `take_screenshot`) for basic tasks:

```json
"args": ["-y", "chrome-devtools-mcp@latest", "--slim", "--no-usage-statistics"]
```

## Chrome DevTools MCP vs Playwright

| Task | Use |
|------|-----|
| Multi-browser (Firefox, WebKit) | Playwright |
| CI/CD test suite | Playwright |
| Formal test assertions (`expect`, `toBeVisible`) | Playwright |
| Connect to existing Chrome session with auth | Chrome DevTools MCP |
| Performance tracing + Lighthouse | Chrome DevTools MCP |
| Memory snapshot | Chrome DevTools MCP |
| Ethical hacking / recon | Chrome DevTools MCP |
| DevTools Protocol (`evaluate_script`) | Chrome DevTools MCP |

## Ethical Hacking Patterns

**Only use against systems you are authorized to test.**

### Route traffic through Burp Suite

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": [
        "-y", "chrome-devtools-mcp@latest",
        "--proxyServer=http://127.0.0.1:8080",
        "--acceptInsecureCerts",
        "--no-usage-statistics"
      ]
    }
  }
}
```

### Connect to an existing Chrome session (preserves auth state)

Useful when the target blocks WebDriver-launched browsers (e.g., some SSO flows).

```bash
# macOS
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/pentest-profile
```

```json
"args": ["-y", "chrome-devtools-mcp@latest", "--browser-url=http://127.0.0.1:9222", "--no-usage-statistics"]
```

### Recon: extract client-side storage

Via `evaluate_script`:

```javascript
JSON.stringify({
  cookies: document.cookie,
  localStorage: Object.assign({}, localStorage),
  sessionStorage: Object.assign({}, sessionStorage)
})
```

### Recon: map API endpoints

Navigate to the target and trigger app actions, then call `list_network_requests` to enumerate XHR/fetch calls, headers, and payloads.

### Recon: inspect security headers

Run `lighthouse_audit` — surfaces missing CSP, HSTS, X-Frame-Options as findings.

### Connect via WebSocket (sandboxed environments)

```bash
curl http://127.0.0.1:9222/json/version | jq '.webSocketDebuggerUrl'
```

```json
"args": [
  "-y", "chrome-devtools-mcp@latest",
  "--wsEndpoint=ws://127.0.0.1:9222/devtools/browser/<id>",
  "--no-usage-statistics"
]
```
