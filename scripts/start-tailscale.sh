#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${TAILSCALE_AUTH_KEY:-}" ]]; then
  echo "TAILSCALE_AUTH_KEY is not set. Add it as a Runtime Secret in the Cloud Agents dashboard."
  exit 1
fi

STATE_DIR="${HOME}/.tailscale"
mkdir -p "${STATE_DIR}"

if ! pgrep -x tailscaled >/dev/null 2>&1; then
  echo "Starting tailscaled (userspace networking)..."
  nohup sudo tailscaled \
    --state="${STATE_DIR}/tailscaled.state" \
    --socket="${STATE_DIR}/tailscaled.sock" \
    --tun=userspace-networking \
    --outbound-http-proxy-listen=localhost:1054 \
    --socks5-server=localhost:1055 \
    >"${STATE_DIR}/tailscaled.log" 2>&1 &
  for _ in $(seq 1 30); do
    if sudo tailscale --socket="${STATE_DIR}/tailscaled.sock" status >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done
fi

export TS_SOCKET="${STATE_DIR}/tailscaled.sock"
# shellcheck disable=SC1091
source "$(dirname "$0")/tailscale-env.sh"

echo "Joining tailnet..."
sudo -E tailscale --socket="${TS_SOCKET}" up \
  --authkey="${TAILSCALE_AUTH_KEY}" \
  --accept-routes \
  --hostname="cursor-cloud-agent" \
  --reset

sudo tailscale --socket="${TS_SOCKET}" status
