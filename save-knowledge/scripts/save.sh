#!/bin/bash
# save.sh — save content to kb inbox + memory, or docs/decisions/
# Usage: ./save.sh "title" "content" ["memory_type"] ["confidence"]
#
# Arguments:
#   title       - Short descriptive title
#   content     - Full content (decision, finding, etc.)
#   memory_type - Optional: decision | technical-finding | user-preference | user-rule (default: decision)
#   confidence  - Optional: low | medium | high (default: high)

set -euo pipefail

TITLE="${1:-}"
CONTENT="${2:-}"
MEMORY_TYPE="${3:-decision}"
CONFIDENCE="${4:-high}"
DATE=$(date +%Y-%m-%d)

if [ -z "$TITLE" ] || [ -z "$CONTENT" ]; then
    echo "Usage: $0 <title> <content> [memory_type] [confidence]"
    exit 1
fi

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

if command -v kb &> /dev/null; then
    VAULT="${KB_VAULT:-$HOME/Knowledge}"
    MEMORY_FILE="$VAULT/memory/${DATE}.md"

    # 1. Save to inbox for classification by kb process
    echo "Saving to inbox..."
    kb "Title: ${TITLE}

${CONTENT}"
    echo "Saved to inbox"

    # 2. Append claim to episodic memory for kb-dream
    echo "Appending to memory..."
    mkdir -p "$VAULT/memory"

    # Escape double quotes for valid YAML (parser is line-based, not a full YAML parser)
    SAFE_TITLE=$(printf '%s' "$TITLE" | sed 's/"/\\"/g')
    SAFE_CONTENT=$(printf '%s' "$CONTENT" | sed 's/"/\\"/g' | tr '\n' ' ')

    # Append claim (file may already exist with other claims from today)
    cat >> "$MEMORY_FILE" << CLAIMEOF
- claim: "${SAFE_TITLE}"
  memory_type: ${MEMORY_TYPE}
  confidence: ${CONFIDENCE}
  context: "${SAFE_CONTENT}"
CLAIMEOF
    echo "Appended to ${MEMORY_FILE}"
else
    OUTDIR="docs/decisions"
    OUTFILE="${OUTDIR}/${DATE}-${SLUG}.md"
    mkdir -p "$OUTDIR"
    cat > "$OUTFILE" << MDEOF
# ${TITLE}

**Date:** ${DATE}

${CONTENT}
MDEOF
    echo "Saved to ${OUTFILE}"
fi
