#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 6 ]]; then
  echo "usage: $0 STAGING_TREE FILE_CONTEXTS OUTPUT_IMG UUID IMAGE_SIZE_BYTES SOURCE_DATE_EPOCH" >&2
  exit 2
fi

tree=$(realpath "$1")
contexts=$(realpath "$2")
output=$(realpath -m "$3")
uuid=$4
image_size=$5
epoch=$6

[[ -d "$tree" ]] || { echo 'staging tree not found' >&2; exit 1; }
[[ -f "$contexts" ]] || { echo 'file_contexts not found' >&2; exit 1; }
[[ "$image_size" =~ ^[0-9]+$ ]] || { echo 'image size must be an integer' >&2; exit 1; }
[[ "$epoch" =~ ^[0-9]+$ ]] || { echo 'source date must be an integer' >&2; exit 1; }
[[ ! -e "$output" ]] || { echo "refusing to overwrite $output" >&2; exit 1; }
command -v mkfs.erofs >/dev/null || { echo 'mkfs.erofs is required' >&2; exit 1; }

mkdir -p "$(dirname "$output")"
mkfs.erofs --quiet '-zlz4hc,9' -T "$epoch" \
  -U "$uuid" \
  --mount-point=/vendor_dlkm \
  --file-contexts="$contexts" \
  "$output" "$tree"
truncate -s "$image_size" "$output"
sha256sum "$output"
