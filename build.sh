#!/bin/bash
set -euo pipefail

SRC=/src
BUILD=/work/build

mkdir -p "$BUILD"
cp -r "$SRC/auto" "$SRC/config" "$BUILD/"
cd "$BUILD"

lb clean --purge || true
lb config
lb build

mkdir -p "$SRC/out"
cp ./*.iso "$SRC/out/seu-linux.iso"

echo "Build completed. ISO available at $SRC/out/seu-linux.iso"