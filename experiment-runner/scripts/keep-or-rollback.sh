#!/bin/bash
# keep-or-rollback.sh — commit if metric improved, revert if not
# Usage: ./keep-or-rollback.sh <new_metric> <baseline_metric> <commit_message>
#
# Exits 0 if kept, 1 if rolled back.
# The agent logs the result in experiments.md regardless of outcome.

set -euo pipefail

NEW_METRIC="${1:-}"
BASELINE="${2:-}"
COMMIT_MSG="${3:-}"

if [ -z "$NEW_METRIC" ] || [ -z "$BASELINE" ] || [ -z "$COMMIT_MSG" ]; then
    echo "Usage: $0 <new_metric> <baseline_metric> <commit_message>"
    exit 2
fi

IS_BETTER=$(python3 -c "print(1 if float('${NEW_METRIC}') > float('${BASELINE}') else 0)")

if [ "$IS_BETTER" = "1" ]; then
    git add -A
    git commit -m "${COMMIT_MSG}"
    echo "KEPT: ${NEW_METRIC} > ${BASELINE} (delta: $(python3 -c "print(float('${NEW_METRIC}') - float('${BASELINE}'))"))"
    exit 0
else
    git checkout . && git clean -fd
    echo "DISCARDED: ${NEW_METRIC} <= ${BASELINE}"
    exit 1
fi
