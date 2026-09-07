#!/usr/bin/env bash
set -euo pipefail

UNRAID_HOST="${UNRAID_HOST:-unraid-docker-1}"
UNRAID_IP="${UNRAID_IP:-100.68.72.35}"
CDP_URL="${CDP_URL:-http://${UNRAID_IP}:9222/json/version}"
WEB_GUI_URL="${WEB_GUI_URL:-https://${UNRAID_IP}:3010/}"

echo "=== Tailscale status ==="
if ! tailscale status >/dev/null 2>&1; then
  echo "Tailscale is not connected. Running start-tailscale.sh..."
  bash "$(dirname "$0")/start-tailscale.sh"
fi
tailscale status

echo
echo "=== Reachability checks ==="
echo "Target host: ${UNRAID_HOST} (${UNRAID_IP})"

if tailscale ping -c 2 "${UNRAID_HOST}"; then
  echo "Tailscale ping OK"
else
  echo "Tailscale ping failed for ${UNRAID_HOST}"
  exit 1
fi

echo
echo "=== CDP check (${CDP_URL}) ==="
if curl -fsS --max-time 10 "${CDP_URL}" >/dev/null; then
  echo "CDP reachable"
else
  echo "CDP not reachable at ${CDP_URL}"
  exit 1
fi

echo
echo "=== Web GUI check (${WEB_GUI_URL}) ==="
if curl -kfsS --max-time 10 "${WEB_GUI_URL}" >/dev/null; then
  echo "Web GUI reachable"
else
  echo "Web GUI not reachable at ${WEB_GUI_URL}"
  exit 1
fi

echo
echo "=== SSH hint ==="
echo "Use: tailscale ssh root@${UNRAID_HOST}"
echo "Unraid is reachable via Tailscale."
