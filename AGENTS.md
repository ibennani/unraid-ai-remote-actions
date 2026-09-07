# Cursor Cloud instructions

## Repository

GitHub: `https://github.com/ibennani/unraid-ai-remote-actions`

## Required secret (dashboard)

Add `TAILSCALE_AUTH_KEY` as a **Runtime Secret** in Cloud Agents → Environments → Unraid AI Remote Actions → Secrets.

Create keys at: https://login.tailscale.com/admin/settings/keys (reusable + ephemeral recommended).

## Network

This environment needs outbound access to Tailscale control plane and your tailnet. Use **Allow all network access** or add Tailscale domains to the allowlist.

## Verify Unraid connectivity

After environment build:

```bash
bash scripts/ensure-unraid.sh
```

Expected target:

- Host: `unraid-docker-1`
- IP: `100.68.72.35`
- CDP: `http://100.68.72.35:9222`
- Web GUI: `https://100.68.72.35:3010/`
- SSH: `tailscale ssh root@unraid-docker-1`
