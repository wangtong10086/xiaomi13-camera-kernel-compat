# Xiaomi 13 camera kernel compatibility

English | [简体中文](README.zh-CN.md)

Reproducible source overlay for the Xiaomi 13 (`fuxi`) camera/OIS fixes used with LineageOS 23.2 / Android 16.

> [!WARNING]
> Release assets are **prerelease, build-specific recovery artifacts**, not universal flash images. Use them only on `fuxi` after matching the ROM, kernel ABI, partition layout, image hash, and rollback path. A mismatch can prevent Android from booting.

The repository contains only the 18 modified or added camera-kernel files. It does not mirror LineageOS or Xiaomi source trees. `scripts/Apply-Overlay.ps1` refuses to apply unless the modules checkout is clean and at the pinned commit.

## What the overlay restores

- BU24721 vendor-specific OIS firmware initialization and post-init flow.
- OIS firmware-name buffer sizing used by the Xiaomi implementation.
- actuator park-lens worker support.
- camera CCI and sensor compatibility changes required by the vendor path.
- flush-request handling needed by the restored pipeline.

These changes are coupled to the pinned kernel/module commits in `UPSTREAMS.md`. Rebase and rebuild after every kernel or vendor_dlkm update.

## Reproduce

1. Clone the two LineageOS repositories and check out the pinned commits.
2. Apply the overlay:

   ```powershell
   ./scripts/Apply-Overlay.ps1 -ModulesRepo '<path-to-android_kernel_xiaomi_sm8550-modules>'
   ```

3. Prepare the matching Lineage clang toolchain and kernel output tree.
4. Run `scripts/build-camera-module.sh` under Linux/WSL. It copies the module to the requested output and applies `llvm-strip --strip-debug`, matching the production-v11 packaging step.
5. Verify the module and, if needed, repack a copy of the matching vendor_dlkm filesystem.
6. Follow `docs/flash-and-rollback.md`; never flash by implicit device or slot.

The locally validated production-v11 artifacts are attached to a GitHub prerelease, not stored in Git history. Their SHA-256 values are in `RELEASES.md`. “Validated” describes one recorded build lineage; it is not a compatibility promise for another ROM or kernel.

## Contributing and security

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request. Report a vulnerability through GitHub's private vulnerability reporting instead of a public issue; see [SECURITY.md](SECURITY.md).

## License

The overlay follows the upstream Linux/camera-kernel licensing and is distributed under GPL-2.0-only where applicable. Existing per-file notices and upstream terms remain authoritative. See [NOTICE.md](NOTICE.md) and [UPSTREAMS.md](UPSTREAMS.md) for provenance.
