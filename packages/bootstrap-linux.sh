#!/usr/bin/env bash
# Linux 초기 설정 스크립트 (chezmoi 실행 전 최소 준비)
# 나머지 패키지들은 chezmoi의 run_once 스크립트에서 설치됨

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

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
  sudo pacman -Syu --noconfirm curl git zsh less
}

install_prerequisites_debian() {
  echo "==> Installing minimal prerequisites (Debian/Ubuntu)..."
  sudo apt-get update
  sudo apt-get install -y curl git zsh less
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

echo "==> Installing uv..."
if ! cmd_exists uv && [[ ! -f ~/.local/bin/uv ]]; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Set zsh as default shell
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "==> Setting zsh as default shell..."
  sudo chsh -s "$(which zsh)" "$USER" || echo "WARNING: Failed to change default shell"
fi

# Setup SSH key from 1Password
setup_ssh_from_1password() {
  echo "==> Setting up SSH key from 1Password..."
  
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  
  # SSH key가 이미 있으면 스킵
  if [[ -f ~/.ssh/id_ed25519 ]]; then
    echo "    SSH key already exists, skipping..."
    return 0
  fi
  
  # OP_SSH_KEY 환경변수 확인
  if [[ -z "${OP_SSH_KEY:-}" ]]; then
    echo "    OP_SSH_KEY not set, skipping SSH setup..."
    echo "    To setup SSH key, run:"
    echo "      export OP_SSH_KEY='op://Private/xxxxxx/private key'"
    echo "      eval \$(op signin)"
    echo "    Then re-run this script"
    return 0
  fi
  
  # 1Password 로그인 상태 확인
  if ! op account get &>/dev/null; then
    echo "    Not signed in to 1Password, skipping SSH setup..."
    echo "    Run 'eval \$(op signin)' and re-run this script"
    return 0
  fi
  
  SSH_KEY_REF="$OP_SSH_KEY"
  
  # private key 경로에서 public key 경로 생성
  SSH_PUB_REF="${SSH_KEY_REF/private key/public key}"
  
  echo "    Extracting SSH key from 1Password..."
  if op read "$SSH_KEY_REF" > ~/.ssh/id_ed25519 2>/dev/null; then
    chmod 600 ~/.ssh/id_ed25519
    
    op read "$SSH_PUB_REF" > ~/.ssh/id_ed25519.pub 2>/dev/null
    chmod 644 ~/.ssh/id_ed25519.pub
    
    # Git 서명 설정
    echo "    Configuring Git commit signing..."
    git config --global gpg.format ssh
    git config --global user.signingkey ~/.ssh/id_ed25519.pub
    git config --global commit.gpgsign true
    
    echo "    SSH key setup complete!"
    echo ""
    echo "    Don't forget to add your public key to GitHub:"
    echo "      - SSH: https://github.com/settings/ssh/new"
    echo "      - Signing: https://github.com/settings/ssh/new?type=signing"
  else
    echo "    Failed to extract SSH key. Please check the reference path."
    rm -f ~/.ssh/id_ed25519
  fi
}

setup_ssh_from_1password

echo ""
echo "=========================================="
echo "Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Add public key to GitHub (if not done):"
echo "     - SSH: https://github.com/settings/ssh/new"
echo "     - Signing: https://github.com/settings/ssh/new?type=signing"
echo "  2. ~/.local/bin/chezmoi init --apply astralhpi"
echo "=========================================="
