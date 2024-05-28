os := os()
home_dir := env_var('HOME')
user := env_var('USER')

nix_version := `cat ./nix-version.txt`

# ===============================================================================
# Main Commands
# ===============================================================================

default:
    just {{os}}

update command="all":
  just --justfile update.just {{command}}

secret command:
    just --justfile keybase.just {{command}}

gc:
  nix store gc

# ===============================================================================
# Shell Essential Configs
# ===============================================================================

shell: nix zsh tmux nvim starship chsh mise

config-dir:
  ./ensure.py dir {{ home_dir }}/.config

mise:
  mise run mise

zsh:
  ./ensure.py link {{ home_dir }}/.zprofile ./zsh/zprofile
  ./ensure.py link {{ home_dir }}/.zshenv ./zsh/zshenv
  ./ensure.py link {{ home_dir }}/.zshrc_symlink ./zsh/zshrc_symlink
  ./ensure.py copy {{ home_dir }}/.zshrc ./zsh/zshrc


tmux: 
  ./ensure.py dir {{ home_dir }}/.tmux/plugins
  ./ensure.py link {{ home_dir }}/.tmux.conf ./tmux/tmux.conf
  ./ensure.py clone {{ home_dir }}/.tmux/plugins/tpm \
      'https://github.com/tmux-plugins/tpm' 
  ./ensure.py clone {{ home_dir }}/.tmux/plugins/tmux-powerline \
      'https://github.com/erikw/tmux-powerline'
  ./ensure.py link {{ home_dir }}/.tmux-powerlinerc \
      ./tmux/powerline/tmux-powerlinerc
  ./ensure.py link {{ home_dir }}/.tmux/powerline \
      ./tmux/powerline

nvim: config-dir
  ./ensure.py clone {{ home_dir }}/.config/nvim \
      'https://github.com/NvChad/NvChad'
  ./ensure.py link {{ home_dir }}/.config/nvim/lua/custom \
      ./nvim/custom
  ./ensure.py link {{ home_dir }}/.config/nvim/ftplugin \
      ./nvim/ftplugin
  ./ensure.py link {{ home_dir }}/.config/nvim/ftdetect \
      ./nvim/ftdetect
  ./ensure.py link {{ home_dir }}/.config/nvim/queries \
      ./nvim/queries
  nvim --headless "+Lazy! sync" +qa

starship:
  ./ensure.py dir ~/.cache/starship
  ./ensure.py link {{ home_dir }}/.config/starship.toml config/starship.toml
  ./ensure.py file {{ home_dir }}/.cache/starship/init.nu \
       "starship init nu > ~/.cache/starship/init.nu"

chsh:
  #!/usr/bin/env bash
  if [ -z `echo $SHELL | grep zsh` ]; then
      echo "Changing shell to zsh"
      chsh -s `which zsh`
      echo "Changed shell to zsh"
  fi

# ===============================================================================
# DevOps Configs
# ===============================================================================

devops: k9s

k9s:
  ./ensure.py dir {{ home_dir }}/.config/k9s
  ./ensure.py link {{ home_dir }}/.config/k9s/skin.yml config/k9s/skin.yml

# ===============================================================================
# GUI Tools Configs
# ===============================================================================

gui: kitty wezterm

kitty: && kitty-icon
  ./ensure.py link {{ home_dir }}/.config/kitty config/kitty

[linux]
kitty-icon:

[macos]
kitty-icon:
  cp config/kitty/kitty.icns /Applications/kitty.app/Contents/Resources/kitty.icns
  touch /Applications/kitty.app
  (sudo killall Finder && sudo killall Finder) &

wezterm:
  ./ensure.py link {{ home_dir }}/.wezterm.lua wezterm/wezterm.lua

# ===============================================================================
# Crypto Configs
# ===============================================================================

[linux]
crypto: keybase op

[linux]
keybase:
  #!/usr/bin/env bash
  if [ -z `which run_keybase` ]; then
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install ./keybase_amd64.deb
  fi

[linux]
op:
  #!/usr/bin/env bash
  if [ -z `which op` ]; then
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
      sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
    sudo gpg --dearmor --output /usr/share/keyrings/2password-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
       sudo tee /etc/apt/sources.list.d/1password.list
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
     sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
     sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
    sudo apt update && sudo apt install 1password-cli  
  fi

# ===============================================================================
# Ubuntu Only
# ===============================================================================

[linux]
linux: shell devops crypto

# ===============================================================================
# macOS Only
# ===============================================================================

[macos]
macos: shell devops polyglot macos-only gui

[macos]
macos-only: brew karabiner hammerspoon yabai nushell sudo-with-touchid keyboard font sketchybar

[macos]
brew:
  cd packages && brew bundle -v

[macos]
karabiner: config-dir
  ./ensure.py link {{ home_dir }}/.config/karabiner karabiner
  

[macos]
yabai: config-dir
  ./ensure.py dir {{ home_dir }}/.config/yabai
  ./ensure.py link {{ home_dir }}/.config/yabai/yabairc config/yabairc
  sudo ./ensure.py link /usr/local/bin/yabai /opt/homebrew/bin/yabai 
  yabai --start-service

[macos]
keyboard:
  defaults write -g InitialKeyRepeat -int 15
  defaults write -g KeyRepeat -int 1
  defaults write -g ApplePressAndHoldEnabled -bool false

[macos]
font:
  #!/usr/bin/env bash
  if [ ! -f /Library/Fonts/SF-Mono-Regular.otf ]; then
      echo "Installing SFMono Fonts"
      cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf /Library/Fonts/
      echo "Installed SFMono Fonts"
  fi

[macos]
hammerspoon:
  ./ensure.py link {{ home_dir }}/.hammerspoon hammerspoon
  sudo ./ensure.py link /usr/local/bin/hs /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs


[macos]
nushell:
  cargo install nu
  ./ensure.py dir '{{ home_dir }}/Library/Application Support/nushell'
  ./ensure.py link {{ home_dir }}'/Library/Application Support/nushell/env.nu' nushell/env.nu
  ./ensure.py link {{ home_dir }}'/Library/Application Support/nushell/config.nu' nushell/config.nu

[macos]
sudo-with-touchid:
  #!/usr/bin/env bash
  if ! cat /etc/pam.d/sudo | grep pam_tid.so > /dev/null; then
    echo "Enabling TouchID for sudo"
    sudo sed -i '' '2s/^/auth       sufficient     pam_tid.so\n/' /etc/pam.d/sudo
  fi
  if ! cat /etc/pam.d/sudo | grep pam_reattach.so > /dev/null; then
    echo "Enabling TouchID for sudo in tmux"
    sudo sed -i '' '2s/^/auth       optional     \/opt\/homebrew\/lib\/pam\/pam_reattach.so\n/' /etc/pam.d/sudo
  fi

[macos]
sketchybar: && sketchybar-app-font
  brew services start sketchybar
  ./ensure.py link {{ home_dir }}/.config/sketchybar config/sketchybar

[macos]
sketchybar-update-app-font: && sketchybar-app-font
    rm {{ home_dir }}/Library/Fonts/sketchybar-app-font.ttf
    rm config/sketchybar/icon_map_fn.sh

[macos]
sketchybar-app-font:
  ./ensure.py download {{ home_dir }}/Library/Fonts/sketchybar-app-font.ttf https://github.com/astralhpi/sketchybar-app-font/releases/download/latest/sketchybar-app-font.ttf
  ./ensure.py download config/sketchybar/icon_map_fn.sh https://github.com/astralhpi/sketchybar-app-font/releases/download/latest/icon_map_fn.sh

# ===============================================================================
# Nix Package Manager
# ===============================================================================

[macos]
nix: nix-darwin nix-home-manager

[linux]
nix: nix-home-manager

nix-home-manager: config-dir
  #!/usr/bin/env bash
  set -e
  rm -rf {{ home_dir }}/.config/nixpkgs
  ./ensure.py link {{ home_dir }}/.config/home-manager nix/home-manager

  if [ -z `command -v home-manager` ]; then
      echo "Installing Home Manager"
      nix-channel --add https://github.com/nix-community/home-manager/archive/release-{{nix_version}}.tar.gz home-manager
      nix-channel --add https://nixos.org/channels/nixpkgs-{{nix_version}}-darwin nixpkgs
      nix-channel --update
      export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
      nix-shell '<home-manager>' -A install
  fi

  nix-channel --update
  home-manager switch

[macos]
nix-darwin:
  #!/usr/bin/env bash
  ./ensure.py dir {{ home_dir }}/.nixpkgs
  ./ensure.py link {{ home_dir }}/.nixpkgs/darwin-configuration.nix nix/darwin/darwin-configuration.nix
  ./ensure.py install darwin-rebuild \
      "nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer" \
      "./result/bin/darwin-installer"

  source /etc/static/bashrc
  darwin-rebuild switch

node2nix:
  #!/usr/bin/env bash
  cd nix/home-manager/node
  nix-env -f '<nixpkgs>' -iA nodePackages.node2nix
  node2nix -i node-packages.json -18

# ===============================================================================
# Polyglot Language Support
# ===============================================================================

polyglot: rust

rust:
  ./ensure.py install rustup "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"

# ===============================================================================
# Zotero Plugin
# ===============================================================================

zotero-addons:
  mkdir -p ./zotero-addons/
  https -do ./zotero-addons/zotero-gpt.xpi github.com/MuiseDestiny/zotero-gpt/releases/latest/download/zotero-gpt.xpi
  https -do ./zotero-addons/zotero-pdf-translate.xpi github.com/windingwind/zotero-pdf-translate/releases/latest/download/zotero-pdf-translate.xpi
  https -do ./zotero-addons/zotero-scihub.xpi github.com/ethanwillis/zotero-scihub/releases/latest/download/zotero-scihub-1.4.4.xpi

