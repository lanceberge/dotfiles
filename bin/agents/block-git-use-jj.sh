#!/bin/bash

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -qE '(^|[;&|][[:space:]]*|&&[[:space:]]*|\|\|[[:space:]]*)git([[:space:]]|$)'; then
  echo "Blocked: use jj (jujutsu) for version control instead" >&2
  exit 2
fi

exit 0
