#!/bin/bash
# measure.sh — TEMPLATE: run experiment and return metric
# IMPORTANT: Adapt this script to your domain before running.
# Output: a single numeric value printed to stdout (e.g., "0.847" or "142")
# Exit 0 on success, non-zero on measurement failure.
#
# Examples:
#
# Test pass rate:
#   result=$(pytest tests/ --tb=no -q 2>&1 | grep -E "passed" | awk '{print $1}')
#   total=$(pytest tests/ --tb=no -q 2>&1 | grep -E "passed|failed" | awk '{sum+=$1} END{print sum}')
#   echo "scale=3; $result / $total" | bc
#
# Benchmark score (Python):
#   python benchmark.py 2>&1 | grep "score:" | awk '{print $2}'
#
# Latency (lower is better — negate the value):
#   ms=$(curl -o /dev/null -s -w '%{time_total}' http://localhost:3000/api/health)
#   echo "-$ms"

set -euo pipefail

echo "ERROR: measure.sh is a template and has not been adapted for this project." >&2
echo "Edit this script to return your domain's metric as a single number." >&2
exit 1
