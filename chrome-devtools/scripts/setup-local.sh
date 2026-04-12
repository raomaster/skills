#!/bin/bash
# setup-local.sh — add chrome-devtools MCP to current project (local scope)
# Does NOT install globally. Run once per project.
# Requires: Claude Code CLI

set -euo pipefail

if ! command -v claude &> /dev/null; then
    echo "✗ Claude Code CLI not found. Install from https://claude.ai/code"
    exit 1
fi

claude mcp add chrome-devtools --scope local -- npx -y chrome-devtools-mcp@latest --no-usage-statistics

echo "✓ chrome-devtools MCP added (local scope, no usage statistics)"
echo ""
echo "  To remove:  claude mcp remove chrome-devtools"
echo "  To verify:  claude mcp list"
echo "  For slim mode (3 tools), edit .claude/settings.local.json and add --slim to args"
