# ⚠️ Archived – use [docker-all-nextcloud-smb](https://github.com/maximilian1001/docker-all-nextcloud-smb) instead

This repository built a single Nextcloud image with smbclient from a **hard-coded** base version (`FROM nextcloud:30-apache`) and published it as `ghcr.io/maximilian1001/nextcloud-smb:latest`.
It is no longer maintained and the image will not receive updates (Nextcloud 30 is end of life).

## Successor: [maximilian1001/docker-all-nextcloud-smb](https://github.com/maximilian1001/docker-all-nextcloud-smb)

Image: `ghcr.io/maximilian1001/docker-all-nextcloud-smb`

- **All supported major versions automatically:** the newest release of every Nextcloud major from 30 up to the current upstream `stable-apache`; a new major is added as soon as upstream marks it stable.
- **Official Nextcloud tags:** `NN-apache`, `NN.N-apache`, `NN.N.N-apache`, `stable-apache`, `production-apache` – same meaning as on [Docker Hub](https://hub.docker.com/_/nextcloud).
- **Daily check, build only on change:** the upstream digest is compared with the `org.opencontainers.image.base.digest` label; weekly rebuild of the newest image per major for Debian security updates.
- **Smoke test before push:** the `smbclient` PHP module must be loaded; Nextcloud, PHP and smbclient versions are shown in the job summary.
- Base image pinned by digest, linux/amd64, untagged versions cleaned up automatically.

## Migration
Replace the image in your compose/stack file, pinned to your **current** major version:

```yaml
# before
image: ghcr.io/maximilian1001/nextcloud-smb:latest
# after (example: you are on Nextcloud 30)
image: ghcr.io/maximilian1001/docker-all-nextcloud-smb:30-apache
```

Then upgrade **one major version at a time** (`30-apache` → `31-apache` → `32-apache` → …), letting each upgrade finish before the next step.
