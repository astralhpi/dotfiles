#!/usr/bin/env bash
# Linux 초기 설정 스크립트 (chezmoi 실행 전 최소 준비)
# 나머지 패키지들은 chezmoi의 run_once 스크립트에서 설치됨

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cmd_exists() { command -v "$1" >/dev/null 2>&1; }

# Distro 감지
detect_distro() {
  if [ -f /etc/arch-release ] || grep -q "ID_LIKE=arch" /etc/os-release 2>/dev/null; then
    echo "arch"
  elif [ -f /etc/debian_version ]; then
    echo "debian"
  else
    echo "unknown"
  fi
}

DISTRO=$(detect_distro)
echo "==> Detected distro: $DISTRO"

install_prerequisites_arch() {
  echo "==> Installing minimal prerequisites (Arch)..."
  sudo pacman -Syu --noconfirm curl git zsh
}

install_prerequisites_debian() {
  echo "==> Installing minimal prerequisites (Debian/Ubuntu)..."
  sudo apt-get update
  sudo apt-get install -y curl git zsh
}

install_1password_arch() {
  if ! cmd_exists op; then
    echo "==> Installing 1Password CLI (Arch)..."
    # AUR에서 1password-cli 설치 (yay 또는 직접 빌드)
    if cmd_exists yay; then
      yay -S --noconfirm 1password-cli
    elif cmd_exists paru; then
      paru -S --noconfirm 1password-cli
    else
      echo "WARNING: No AUR helper found. Installing yay first..."
      sudo pacman -S --noconfirm --needed base-devel git
      git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
      (cd /tmp/yay-bin && makepkg -si --noconfirm)
      rm -rf /tmp/yay-bin
      yay -S --noconfirm 1password-cli
    fi
  fi
}

install_1password_debian() {
  if ! cmd_exists op; then
    echo "==> Installing 1Password CLI (Debian/Ubuntu)..."
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
      sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
      sudo tee /etc/apt/sources.list.d/1password.list
    sudo apt-get update && sudo apt-get install -y 1password-cli
  fi
}

case "$DISTRO" in
  arch)
    install_prerequisites_arch
    install_1password_arch
    ;;
  debian)
    install_prerequisites_debian
    install_1password_debian
    ;;
  *)
    echo "ERROR: Unsupported distribution"
    exit 1
    ;;
esac

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

# Set zsh as default shell
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "==> Setting zsh as default shell..."
  sudo chsh -s "$(which zsh)" "$USER" || echo "WARNING: Failed to change default shell"
fi

echo ""
echo "=========================================="
echo "Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. op signin"
echo "  2. ~/.local/bin/chezmoi init --apply <github-user>"
echo "=========================================="
