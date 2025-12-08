#!/usr/bin/env bash

# tmux 플러그인 설치 (TPM 없이 직접 관리)

set -uo pipefail

TMUX_PLUGINS_DIR="$HOME/.tmux/plugins"

clone_or_pull() {
  local repo="$1"
  local dest="$2"
  
  if [[ -d "$dest" ]]; then
    echo "==> Updating $repo..."
    git -C "$dest" pull --quiet 2>/dev/null || true
  else
    echo "==> Cloning $repo..."
    git clone --depth 1 "https://github.com/$repo.git" "$dest"
  fi
}

main() {
  mkdir -p "$TMUX_PLUGINS_DIR"

  # Catppuccin 테마
  clone_or_pull "catppuccin/tmux" "$TMUX_PLUGINS_DIR/catppuccin"

  # tmux-which-key (키바인딩 도움말)
  clone_or_pull "alexwforsythe/tmux-which-key" "$TMUX_PLUGINS_DIR/tmux-which-key"

  # tmux-fzf (세션/윈도우/pane 선택)
  clone_or_pull "sainnhe/tmux-fzf" "$TMUX_PLUGINS_DIR/tmux-fzf"

  # tmux-resurrect (세션 저장/복구)
  clone_or_pull "tmux-plugins/tmux-resurrect" "$TMUX_PLUGINS_DIR/tmux-resurrect"

  # tmux-fzf-url (URL picker)
  clone_or_pull "wfxr/tmux-fzf-url" "$TMUX_PLUGINS_DIR/tmux-fzf-url"

  # extrakto (output에서 텍스트 추출/복사)
  clone_or_pull "laktak/extrakto" "$TMUX_PLUGINS_DIR/extrakto"

  echo "==> tmux plugins installed!"
}

main "$@"
