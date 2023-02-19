os := os()
home_dir := env_var('HOME')
user := env_var('USER')

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

shell: nix zsh tmux nvim starship chsh

config-dir:
  ./ensure.py dir {{ home_dir }}/.config

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
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

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

gui: kitty

kitty: && kitty-icon
  ./ensure.py link {{ home_dir }}/.config/kitty config/kitty

[linux]
kitty-icon:

[macos]
kitty-icon:
  cp config/kitty/kitty.icns /Applications/kitty.app/Contents/Resources/kitty.icns
  touch /Applications/kitty.app
  sudo killall Finder && sudo killall Finder

# ===============================================================================
# Ubuntu Only
# ===============================================================================

[linux]
linux: shell devops

[linux]
packages:


# ===============================================================================
# macOS Only
# ===============================================================================

[macos]
macos: gui shell devops polyglot macos-only

[macos]
macos-only: brew karabiner hammerspoon yabai ubersicht nushell sudo-with-touchid keyboard font

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
  brew services start yabai

[macos]
ubersicht:
  ./ensure.py dir '{{ home_dir }}/Library/Application Support/Übersicht/widgets'
  ./ensure.py clone {{ home_dir }}'/Library/Application Support/Übersicht/widgets/simple-bar' \
      'https://github.com/Jean-Tinland/simple-bar'

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
  ./ensure.py dir '{{ home_dir }}/Library/Application Support/nushell'
  ./ensure.py link {{ home_dir }}'/Library/Application Support/nushell/env.nu' nushell/env.nu
  ./ensure.py link {{ home_dir }}'/Library/Application Support/nushell/config.nu' nushell/config.nu

[macos]
sudo-with-touchid:
  #!/usr/bin/env bash
  if ! cat /etc/pam.d/sudo | grep pam_tid.so > /dev/null; then
    echo "Enabling TouchID for sudo"
    sudo sed -i '' '2s/^/auth       sufficient     pam_tid.so\\n/' /etc/pam.d/sudo
  fi
  if ! cat /etc/pam.d/sudo | grep pam_reattach.so > /dev/null; then
    echo "Enabling TouchID for sudo in tmux"
    sudo sed -i '' '2s/^/auth       optional     \/opt\/homebrew\/lib\/pam\/pam_reattach.so\\n/' /etc/pam.d/sudo
  fi

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
  ./ensure.py link {{ home_dir }}/.config/nixpkgs nix/home-manager

  if [ -z `command -v home-manager` ]; then
      echo "Installing Home Manager"
      nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
      nix-channel --update
      export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
      nix-shell '<home-manager>' -A install
  fi

  home-manager switch

[macos]
nix-darwin:
  ./ensure.py dir {{ home_dir }}/.nixpkgs
  ./ensure.py link {{ home_dir }}/.nixpkgs/darwin-configuration.nix nix/darwin/darwin-configuration.nix
  ./ensure.py install darwin-rebuild \
      "nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer" \
      "./result/bin/darwin-installer"

  darwin-rebuild switch

node2nix:
  #!/usr/bin/env bash
  cd nix/node
  nix-env -f '<nixpkgs>' -iA nodePackages.node2nix
  node2nix -i node-packages.json

  # ===============================================================================
# Polyglot Language Support
# ===============================================================================

polyglot: rust

rust:
  ./ensure.py install rustup "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
