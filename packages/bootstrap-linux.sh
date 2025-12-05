#!/usr/bin/env bash
# Linux 초기 설정 스크립트 (chezmoi 실행 전 최소 준비)
# 나머지 패키지들은 chezmoi의 run_once 스크립트에서 설치됨

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cmd_exists() { command -v "$1" >/dev/null 2>&1; }

echo "==> Installing minimal prerequisites..."
sudo apt-get update
sudo apt-get install -y curl git zsh

echo "==> Installing 1Password CLI..."
if ! cmd_exists op; then
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
    sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
    sudo tee /etc/apt/sources.list.d/1password.list
  sudo apt-get update && sudo apt-get install -y 1password-cli
fi

echo "==> Installing chezmoi..."
if ! cmd_exists chezmoi && [[ ! -f ~/.local/bin/chezmoi ]]; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
fi

echo "==> Installing ghostty terminfo..."
if ! infocmp xterm-ghostty &>/dev/null; then
  if [[ -f "$SCRIPT_DIR/ghostty.terminfo" ]]; then
    tic -x "$SCRIPT_DIR/ghostty.terminfo"
  fi
fi

echo ""
echo "=========================================="
echo "Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. op signin"
echo "  2. ~/.local/bin/chezmoi init --apply <github-user>"
echo "=========================================="
