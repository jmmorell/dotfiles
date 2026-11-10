#!/usr/bin/env bash
# Link dotfiles into $HOME with GNU Stow. Safe to re-run.
# Usage: ./install.sh [package ...]   (default: all packages)
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES=("$@")
[ ${#PACKAGES[@]} -eq 0 ] && PACKAGES=(bash zsh vim kitty git claude)

for cmd in git stow; do
  command -v "$cmd" >/dev/null || { echo "error: '$cmd' is required" >&2; exit 1; }
done

for pkg in "${PACKAGES[@]}"; do
  [ -d "$DIR/$pkg" ] || { echo "error: unknown package '$pkg'" >&2; exit 1; }
done

# Shared dirs must be real directories, never symlinks into this repo:
# otherwise every app (and Claude Code's credentials) would write here.
mkdir -p "$HOME/.config" "$HOME/.claude"

stow_args=(-d "$DIR" -t "$HOME" -R "${PACKAGES[@]}")

# Dry run first: stow never overwrites, so report conflicts and stop.
if ! out=$(stow -n "${stow_args[@]}" 2>&1); then
  echo "$out" >&2
  echo "Conflicts found. Back up or remove the files above, then re-run." >&2
  exit 1
fi
stow "${stow_args[@]}"
echo "Linked: ${PACKAGES[*]}"

git -C "$DIR" config core.hooksPath githooks
echo "Enabled gitleaks pre-commit hook"

missing=()
command -v gh       >/dev/null || missing+=("gh")
command -v gitleaks >/dev/null || missing+=("gitleaks (pre-commit hook will refuse commits)")
command -v zsh      >/dev/null || missing+=("zsh")
[ -d "$HOME/.oh-my-zsh" ]      || missing+=("Oh My Zsh")
[ -f "$HOME/.vim/autoload/plug.vim" ] || missing+=("vim-plug")
command -v kitty    >/dev/null || missing+=("kitty")
if [ ${#missing[@]} -gt 0 ]; then
  echo "Optional dependencies not found:"
  printf '  - %s\n' "${missing[@]}"
fi
