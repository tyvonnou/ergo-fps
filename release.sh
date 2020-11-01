#!/bin/bash

declare -r PROJECT_PATH="${0%\/*}"
declare -r EXPORT_DIR="${PROJECT_PATH}/export"
declare -r GAME="ErgoFPS"

declare dest
cd "${EXPORT_DIR}"
for dir in *; do
  if [ "${dir}" = "Mac" ]; then
    continue
  fi
  cd "${dir}"
  dest="${GAME}-${dir}.7z"
  rm -f "${dest}"
  7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=64m -ms=on "${dest}" *
  cd "${OLDPWD}"
done
