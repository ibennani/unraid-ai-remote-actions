# Cursor Cloud instructions

## Repository

GitHub: `https://github.com/ibennani/unraid-ai-remote-actions`

## Required secret

Set `TAILSCALE_AUTH_KEY` as a **Runtime Secret** in the Cloud Agents dashboard for this environment.

## Verify Unraid connectivity

After the environment build completes, run:

```bash
bash scripts/ensure-unraid.sh
```

Expected target:

- Host: `unraid-docker-1`
- IP: `100.68.72.35`
- CDP: `http://100.68.72.35:9222`
- Web GUI: `https://100.68.72.35:3010/`

## SSH

```bash
tailscale ssh root@unraid-docker-1
```
