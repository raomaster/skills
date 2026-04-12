#!/bin/bash
# check-playwright.sh — verify Playwright is installed
# Does NOT auto-install. Reports status and suggests install command.

set -euo pipefail

if command -v playwright &> /dev/null; then
    echo "✓ Playwright CLI found: $(playwright --version)"
    exit 0
fi

if [ -f "node_modules/.bin/playwright" ]; then
    echo "✓ Playwright found in node_modules"
    echo "  Version: $(node_modules/.bin/playwright --version)"
    echo "  Run via: npx playwright <command>"
    exit 0
fi

echo "✗ Playwright not found in PATH or node_modules"
echo ""
echo "To install in a new project:"
echo "  npm init playwright@latest"
echo ""
echo "To add to an existing project:"
echo "  npm install -D @playwright/test"
echo "  npx playwright install"
exit 1
