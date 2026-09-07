#!/usr/bin/env bash
# Proxy env required for TCP/HTTP over Tailscale userspace networking in Cloud Agents.
export ALL_PROXY="socks5h://localhost:1055/"
export HTTP_PROXY="http://localhost:1054/"
export HTTPS_PROXY="http://localhost:1054/"
