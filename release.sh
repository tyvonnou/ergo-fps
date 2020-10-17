#!/bin/bash

declare -r EXPORT_DIR="export"
declare -r GAME="ErgoFPS"
declare -r -a folders=(linux windows html5)

declare dest
for f in "${folders[@]}"; do
  dest="${f:0:1}"
  dest="${EXPORT_DIR}/${f}/${GAME}-${dest^^}${f:1}"
  rm -f "${dest}"
  7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=64m -ms=on "${dest}" "${EXPORT_DIR}/${f}"
done
