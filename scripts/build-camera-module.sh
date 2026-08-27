#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 5 || $# -gt 6 ]]; then
  echo "usage: $0 KERNEL_ROOT MODULES_ROOT KERNEL_OUT MMRM_MODULE_SYMVERS OUTPUT_KO [JOBS]" >&2
  exit 2
fi

kernel_root=$(realpath "$1")
modules_root=$(realpath "$2")
kernel_out=$(realpath "$3")
mmrm_symvers=$(realpath "$4")
output_ko=$(realpath -m "$5")
jobs=${6:-8}
camera_root="$modules_root/qcom/opensource/camera-kernel"

[[ -f "$kernel_root/Makefile" ]] || { echo 'kernel Makefile not found' >&2; exit 1; }
[[ -f "$camera_root/Kbuild" ]] || { echo 'camera Kbuild not found' >&2; exit 1; }
[[ -f "$mmrm_symvers" ]] || { echo 'MMRM Module.symvers not found' >&2; exit 1; }
[[ -d "$kernel_out" ]] || { echo 'prepared kernel output tree not found' >&2; exit 1; }
command -v clang >/dev/null || { echo 'matching Lineage clang toolchain is not on PATH' >&2; exit 1; }
command -v llvm-strip >/dev/null || { echo 'matching llvm-strip is not on PATH' >&2; exit 1; }

make -C "$kernel_root" \
  O="$kernel_out" \
  ARCH=arm64 \
  LLVM=1 \
  LLVM_IAS=1 \
  M="$camera_root" \
  CAMERA_KERNEL_ROOT="$camera_root" \
  KERNEL_ROOT="$kernel_root" \
  MODNAME=camera \
  BOARD_PLATFORM=kalama \
  KBUILD_EXTRA_SYMBOLS="$mmrm_symvers" \
  -j"$jobs" modules

module="$camera_root/camera.ko"
[[ -f "$module" ]] || { echo "build completed without $module" >&2; exit 1; }
mkdir -p "$(dirname "$output_ko")"
install -m 0644 "$module" "$output_ko"
llvm-strip --strip-debug "$output_ko"
sha256sum "$output_ko"
