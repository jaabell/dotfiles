#!/bin/bash
# Snapshot this machine's explicitly-installed packages into packages/<hostname>/.
# Read-only: never installs, removes, or upgrades anything.
#
# Usage: packages/update.sh   (run from anywhere; writes into the repo this
# script lives in, under a directory named after `hostname`)

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
host="$(hostname)"
out_dir="$repo_root/packages/$host"
mkdir -p "$out_dir"

# Native (official repo) packages, explicitly installed (not pulled in as a
# dependency of something else).
LC_ALL=C pacman -Qqen | LC_ALL=C sort >"$out_dir/pacman-native.txt"

# Foreign packages (AUR, via yay or manual makepkg), explicitly installed.
LC_ALL=C pacman -Qqem | LC_ALL=C sort >"$out_dir/pacman-aur.txt"

echo "Wrote $out_dir/pacman-native.txt ($(wc -l <"$out_dir/pacman-native.txt") packages)"
echo "Wrote $out_dir/pacman-aur.txt ($(wc -l <"$out_dir/pacman-aur.txt") packages)"
echo
echo "Review with: git -C '$repo_root' diff -- packages/$host"
