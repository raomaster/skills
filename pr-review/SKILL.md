---
name: pr-review
description: Use when reviewing PRs, reading code review feedback, or responding to review comments from Codex, bots, or teammates. Triggers on "review PR", "check PR comments", "what did Codex say", "PR feedback".
---

# PR Review Comments

When reviewing a PR, use `gh api` to fetch inline review comments — they are NOT visible with `gh pr view --comments`.

## How to fetch PR review comments

```bash
# For a specific PR number:
gh api repos/{owner}/{repo}/pulls/{pr_number}/comments --jq '.[] | {path: .path, line: .line, body: .body, user: .user.login}'

# Or for the current branch's PR:
PR_NUMBER=$(gh pr view --json number --jq '.number')
gh api repos/{owner}/{repo}/pulls/$PR_NUMBER/comments --jq '.[] | {path: .path, line: .line, body: .body, user: .user.login}'
```

## Key insight

`gh pr view --comments` only shows **issue-level** comments. Inline **code review** comments live in a different API endpoint:

- **Issue comments:** `gh pr view --comments` or `gh api .../issues/{n}/comments`
- **Review comments (inline):** `gh api .../pulls/{n}/comments`
- **Reviews (summary):** `gh api .../pulls/{n}/reviews`

## Workflow

1. Get the PR number: `gh pr view --json number --jq '.number'`
2. Fetch inline comments: `gh api repos/{owner}/{repo}/pulls/{pr_number}/comments`
3. For each comment, read the file at the referenced line
4. Evaluate whether the comment is valid
5. If valid, fix it. If not, explain why.

## Formatting the output

Use `--jq` to format results readably:
```bash
gh api repos/{owner}/{repo}/pulls/$PR/comments --jq '.[] | "\(.path):\(.line) — @\(.user.login)\n\(.body)\n"'
```
