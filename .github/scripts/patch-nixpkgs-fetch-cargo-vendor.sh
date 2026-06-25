#!/usr/bin/env bash
set -euo pipefail

patched_nixpkgs="${RUNNER_TEMP:?}/nixpkgs-crates-user-agent"
nixpkgs_path="$(
  nix eval --impure --raw --expr 'let flake = builtins.getFlake (toString ./.); in flake.inputs.nixpkgs.outPath'
)"

if [ -e "$patched_nixpkgs" ]; then
  find "$patched_nixpkgs" -type d -exec chmod u+w {} + 2>/dev/null || true
  rm -rf "$patched_nixpkgs"
fi

mkdir -p "$patched_nixpkgs"
if ! cp -al "$nixpkgs_path/." "$patched_nixpkgs/" 2>/dev/null; then
  find "$patched_nixpkgs" -type d -exec chmod u+w {} + 2>/dev/null || true
  rm -rf "$patched_nixpkgs"
  mkdir -p "$patched_nixpkgs"
  cp -R "$nixpkgs_path/." "$patched_nixpkgs/"
fi

fetch_cargo_vendor_util="$patched_nixpkgs/pkgs/build-support/rust/fetch-cargo-vendor-util.py"
chmod u+w "$(dirname "$fetch_cargo_vendor_util")"
rm "$fetch_cargo_vendor_util"
cp "$nixpkgs_path/pkgs/build-support/rust/fetch-cargo-vendor-util.py" "$fetch_cargo_vendor_util"
chmod u+w "$fetch_cargo_vendor_util"

python3 - "$fetch_cargo_vendor_util" <<'PY'
import sys
from pathlib import Path

path = Path(sys.argv[1])
text = path.read_text()

needle = "    session = requests.Session()\n"
replacement = """    session = requests.Session()
    session.headers.update({
        "User-Agent": "cargo/1.0 (github-actions; +https://github.com/aiwao/dotfiles)",
    })
"""

if replacement in text:
    pass
elif needle in text:
    text = text.replace(needle, replacement, 1)
else:
    raise SystemExit("Could not find requests.Session() in fetch-cargo-vendor-util.py")

path.write_text(text)
PY

echo "path=$patched_nixpkgs" >> "$GITHUB_OUTPUT"
