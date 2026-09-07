#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${TAILSCALE_AUTH_KEY:-}" ]]; then
  echo "TAILSCALE_AUTH_KEY is not set. Add it as a Runtime Secret in the Cloud Agents dashboard."
  exit 1
fi

if ! pgrep -x tailscaled >/dev/null 2>&1; then
  sudo tailscaled \
    --tun=userspace-networking \
    --outbound-http-proxy-listen=localhost:1054 \
    --socks5-server=localhost:1055 &
  sleep 2
fi

export ALL_PROXY="socks5h://localhost:1055/"
export HTTP_PROXY="http://localhost:1054/"
export HTTPS_PROXY="http://localhost:1054/"

sudo -E tailscale up \
  --authkey="${TAILSCALE_AUTH_KEY}" \
  --accept-routes \
  --hostname="cursor-cloud-agent" \
  --reset

tailscale status
