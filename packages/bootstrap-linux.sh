#!/usr/bin/env bash
# Linux 초기 설정 스크립트 (chezmoi 실행 전에 수동으로 실행)

set -euo pipefail

cmd_exists() { command -v "$1" >/dev/null 2>&1; }

echo "==> Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y zsh git curl build-essential tmux neovim fzf ripgrep fd-find direnv ncurses-term

echo "==> Installing ghostty terminfo..."
if ! infocmp xterm-ghostty &>/dev/null; then
  # terminfo는 dotfiles repo에 포함되어 있음
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -f "$SCRIPT_DIR/ghostty.terminfo" ]]; then
    tic -x "$SCRIPT_DIR/ghostty.terminfo"
  else
    echo "Warning: ghostty.terminfo not found, skipping"
  fi
fi

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

echo "==> Installing mise..."
if ! cmd_exists mise && [[ ! -f ~/.local/bin/mise ]]; then
  curl https://mise.run | sh
fi

echo "==> Installing starship..."
if ! cmd_exists starship && [[ ! -f ~/.local/bin/starship ]]; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
fi

echo "==> Installing atuin..."
if [[ ! -f ~/.atuin/bin/atuin ]]; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

echo "==> Installing zoxide..."
if ! cmd_exists zoxide && [[ ! -f ~/.local/bin/zoxide ]]; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

echo "==> Setting zsh as default shell..."
if [[ "$SHELL" != *"zsh"* ]]; then
  sudo chsh -s "$(which zsh)" "$USER"
fi

echo ""
echo "=========================================="
echo "Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. op signin"
echo "  2. ~/.local/bin/chezmoi init --apply <github-user>"
echo "=========================================="
