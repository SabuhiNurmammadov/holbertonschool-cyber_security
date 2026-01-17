#!/bin/bash
in="${1#\{xor\}}"
printf '%s' "$in" | base64 -d 2>/dev/null | python3 - <<'PY'
import sys
data=sys.stdin.buffer.read()
sys.stdout.buffer.write(bytes((b ^ 0x5f) for b in data))
PY
