#!/usr/bin/env bash
# macOS Headless 초기 설정 스크립트 (Mac Mini 서버용)
# 1. SSH/Tailscale로 접속한 상태에서 실행
# 2. 1Password CLI로 인증
# 3. chezmoi로 dotfiles 적용

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

cmd_exists() { command -v "$1" >/dev/null 2>&1; }

echo "=========================================="
echo "macOS Headless Bootstrap"
echo "=========================================="
echo ""

# =============================================================================
# Homebrew 설치
# =============================================================================
if ! cmd_exists brew; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Homebrew PATH 설정
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "==> Homebrew already installed"
fi

# =============================================================================
# 1Password CLI 설치
# =============================================================================
if ! cmd_exists op; then
  echo "==> Installing 1Password CLI..."
  brew install --cask 1password-cli
else
  echo "==> 1Password CLI already installed"
fi

# =============================================================================
# Tailscale CLI 설치 및 서비스 등록
# =============================================================================
if ! cmd_exists tailscale; then
  echo "==> Installing Tailscale..."
  brew install tailscale
else
  echo "==> Tailscale already installed"
fi

# Tailscale 서비스 시작
echo "==> Starting Tailscale service..."
sudo brew services start tailscale

# Tailscale 로그인 상태 확인
if ! tailscale status &>/dev/null; then
  echo ""
  echo "==> Tailscale login required!"
  echo "    Run: sudo tailscale up --ssh"
  echo ""
  echo "    This will enable Tailscale SSH access."
  echo "    After login, you can access this machine via:"
  echo "      ssh <your-tailscale-hostname>"
  echo ""
fi

# =============================================================================
# chezmoi 설치
# =============================================================================
if ! cmd_exists chezmoi; then
  echo "==> Installing chezmoi..."
  brew install chezmoi
else
  echo "==> chezmoi already installed"
fi

# =============================================================================
# Headless 모드 마커 생성
# =============================================================================
echo "==> Setting up headless mode marker..."
mkdir -p ~/.config/chezmoi
chmod 700 ~/.config/chezmoi
touch ~/.config/chezmoi/.headless
echo "    Created ~/.config/chezmoi/.headless"

# =============================================================================
# SSH 키 설정 안내
# =============================================================================
setup_ssh_key() {
  echo ""
  echo "==> SSH Key Setup"
  echo ""
  
  if [[ -f ~/.ssh/id_ed25519 ]]; then
    echo "    SSH key already exists at ~/.ssh/id_ed25519"
    return 0
  fi
  
  echo "    Headless 모드에서는 SSH 키를 다음 방법 중 하나로 설정하세요:"
  echo ""
  echo "    옵션 1) 1Password에서 가져오기:"
  echo "      eval \$(op signin)"
  echo "      op read 'op://Private/SSH Key/private key' > ~/.ssh/id_ed25519"
  echo "      op read 'op://Private/SSH Key/public key' > ~/.ssh/id_ed25519.pub"
  echo "      chmod 600 ~/.ssh/id_ed25519"
  echo ""
  echo "    옵션 2) 새 키 생성:"
  echo "      ssh-keygen -t ed25519 -C \"your-email@example.com\""
  echo ""
  echo "    옵션 3) 다른 머신에서 복사 (Tailscale SSH 사용):"
  echo "      scp other-machine:~/.ssh/id_ed25519* ~/.ssh/"
  echo ""
}

setup_ssh_key

# =============================================================================
# 1Password 로그인 안내
# =============================================================================
echo ""
echo "=========================================="
echo "Bootstrap complete!"
echo ""
echo "Next steps:"
echo ""
echo "  1. Tailscale 로그인 (아직 안했다면):"
echo "     sudo tailscale up --ssh"
echo ""
echo "  2. 1Password 로그인:"
echo "     eval \$(op signin)"
echo ""
echo "  3. SSH 키 설정 (위 안내 참조)"
echo ""
echo "  4. chezmoi 초기화:"
echo "     chezmoi init --apply astralhpi"
echo ""
echo "  5. GitHub에 SSH 키 등록:"
echo "     - SSH key: https://github.com/settings/ssh/new"
echo "     - Signing key: https://github.com/settings/ssh/new?type=signing"
echo "     cat ~/.ssh/id_ed25519.pub | pbcopy"
echo ""
echo "=========================================="
