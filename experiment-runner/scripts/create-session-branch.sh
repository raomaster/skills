#!/bin/bash
# create-session-branch.sh — create an autoresearch session branch
# Creates: autoresearch/session-YYYY-MM-DD
# Fails if working tree is dirty — the loop requires a clean starting point.

set -euo pipefail

DATE=$(date +%Y-%m-%d)
BRANCH="autoresearch/session-${DATE}"

# Require clean working tree
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "Error: working tree is dirty. Commit or stash changes before starting."
    git status --short
    exit 1
fi

# Fail if branch already exists
if git rev-parse --verify "$BRANCH" &> /dev/null; then
    echo "Error: branch '$BRANCH' already exists."
    echo "Use a different date suffix or delete the existing branch first:"
    echo "  git branch -D $BRANCH"
    exit 1
fi

git checkout -b "$BRANCH"
echo "✓ Created session branch: $BRANCH"
echo "  Main branch will not be touched during the loop."
