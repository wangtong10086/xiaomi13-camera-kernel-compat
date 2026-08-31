# Contributing

[简体中文](CONTRIBUTING.zh-CN.md)

Contributions are welcome when they remain reproducible, reviewable, and specific to Xiaomi 13 (`fuxi`).

1. Start from the pinned upstream commits in `UPSTREAMS.md` and keep the checkout clean.
2. Keep changes grouped by subsystem and explain the observed failure, target ROM/kernel, and rollback result.
3. Do not commit firmware, complete vendor trees, device dumps, signing keys, serial numbers, tokens, logs with personal data, or proprietary APK/ROM images.
4. Preserve existing copyright and license notices. Do not add a guessed SPDX identifier to a vendor-derived file.
5. Run `scripts/Apply-Overlay.ps1` against a fresh pinned checkout and run shell syntax/static checks before opening a PR.
6. Never include a one-click flash command. Documentation must require an explicit serial, exact partition, verified hash, and tested rollback image.

For compatibility reports, include non-sensitive build fingerprints, exact commits, hashes, relevant sanitized logs, and whether rollback succeeded.
