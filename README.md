# Unraid AI Remote Actions

Cursor Cloud Agent environment for reaching a private Unraid server over Tailscale.

## Unraid target

| Setting | Value |
|---------|-------|
| Hostname | `unraid-docker-1` |
| Tailscale IP | `100.68.72.35` |
| CDP | `http://100.68.72.35:9222` |
| Web GUI | `https://100.68.72.35:3010/` |
| SSH | `tailscale ssh root@unraid-docker-1` |

## Setup

1. Add `TAILSCALE_AUTH_KEY` as a **Runtime Secret** in the [Cloud Agents dashboard](https://cursor.com/dashboard/cloud-agents).
2. Point the Cloud Agent environment at this repository (GitHub).
3. Run a new setup/build so the environment picks up the secret.

## Verify connectivity

```bash
bash scripts/ensure-unraid.sh
```

## Notes

- Tailscale runs in userspace networking mode in Cloud Agent VMs.
- Do not commit secrets to this repository.
