#!/bin/bash
# save.sh — save content to kb or docs/decisions/
# Usage: ./save.sh "title" "content"

set -euo pipefail

TITLE="${1:-}"
CONTENT="${2:-}"
DATE=$(date +%Y-%m-%d)

if [ -z "$TITLE" ] || [ -z "$CONTENT" ]; then
    echo "Usage: $0 <title> <content>"
    exit 1
fi

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

if command -v kb &> /dev/null; then
    echo "Saving via kb..."
    kb add "${TITLE}: ${CONTENT}"
    echo "✓ Saved to knowledge base"
else
    OUTDIR="docs/decisions"
    OUTFILE="${OUTDIR}/${DATE}-${SLUG}.md"
    mkdir -p "$OUTDIR"
    cat > "$OUTFILE" << MDEOF
# ${TITLE}

**Date:** ${DATE}

${CONTENT}
MDEOF
    echo "✓ Saved to ${OUTFILE}"
fi
