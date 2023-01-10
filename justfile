os := os()
home_dir := env_var('HOME')

default:
    just {{os}}

common: nix packages font polyglot zsh tmux nvim starship chsh

zsh: (
    _link 'zsh/zprofile' home_dir / '.zprofile') (
    _link 'zsh/zshenv' home_dir / '.zshenv') (
    _link 'zsh/zshrc_symlink' home_dir / '.zshrc_symlink') (
    _cp 'zsh/zshrc' home_dir / '.zshrc')

tmux: (
    _link 'tmux/tmux.conf' home_dir / '.tmux.conf') (
    _clone 'https://github.com/tmux-plugins/tpm' home_dir / '.tmux/plugins/tpm') (
    _clone 'https://github.com/erikw/tmux-powerline' home_dir / '.tmux/plugins/tmux-powerline') (
    _link 'tmux/powerline/tmux-powerlinerc' home_dir / '.tmux-powerlinerc') (
    _link 'tmux/powerline' home_dir / '.tmux/powerline'
    )

nvim: _config-dir (
      _clone 'https://github.com/NvChad/NvChad' home_dir / '.config/nvim') (
      _link 'nvim/custom' home_dir / '.config/nvim/lua/custom') (
      _link 'nvim/ftplugin' home_dir / '.config/nvim/ftplugin')
    nvim

k9s: _k9s-dir && (_link 'config/k9s/skin.yml' home_dir / '.config/k9s/skin.yml')

starship: (_link 'config/starship.toml' home_dir / '.config/starship.toml')
  mkdir -p ~/.cache/starship
  starship init nu > ~/.cache/starship/init.nu

chsh: chsh-zsh

chsh-zsh: (_run-if "[ -z `echo $SHELL | grep zsh` ]" "chsh -s `which zsh`")
chsh-nushell: (_run-if "[ -z `echo $SHELL | grep zsh` ]" "chsh -s `which zsh`")

secret command:
    just --justfile keybase.just {{command}}

# ===============================================================================
# macOS Only
# ===============================================================================

[macos]
macos: common karabiner hammerspoon nushell sudo-with-touchid keyboard

[macos]
packages: packages-brew

[macos]
packages-brew:
    cd packages && brew bundle -v

[macos]
karabiner: _config-dir && (_link 'karabiner' home_dir / '.config/karabiner')

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
hammerspoon: (_link 'hammerspoon' home_dir / '.hammerspoon')

[macos]
nushell: (
    _dir home_dir / "'/Library/Application Support/nushell'") (
    _link 'nushell/env.nu' home_dir / "'/Library/Application Support/nushell/env.nu'") (
    _link 'nushell/config.nu' home_dir / "'/Library/Application Support/nushell/config.nu'")
  #!/usr/bin/env nu

[macos]
sudo-with-touchid: (_run-if 
        "! cat /etc/pam.d/sudo | grep pam_tid.so > /dev/null"
        "sudo sed -i '' '2s/^/auth       sufficient     pam_tid.so\\n/' /etc/pam.d/sudo"
    )

# ===============================================================================
# Nix Package Manager
# ===============================================================================

nix: _nix-pkg-manager _nix-modules

[macos]
_nix-pkg-manager: (
  _install-if-not-installed
    "nix"
    "sh <(curl -L https://nixos.org/nix/install)") (
  _nix-modules)

[linux]
_nix-pkg-manager: (
  _install-if-not-installed
    "nix"
    "sh <(curl -L https://nixos.org/nix/install) --daemon") (
  _nix-modules)

[macos]
_nix-modules: nix-darwin nix-home-manager

[linux]
nix-modules: nix-home-manager

nix-home-manager: (
  _dir home_dir / ".config/nixpkgs") (
  _link "nix/home.nix" home_dir / ".config/nixpkgs/home.nix") (
  _link "nix/packages.nix" home_dir / ".config/nixpkgs/packages.nix") (
  _link "nix/node" home_dir / ".config/nixpkgs/node") (
  _link "nix/tools" home_dir / ".config/nixpkgs/tools")
    #!/usr/bin/env bash
    set -e
    if [ -z `command -v home-manager` ]; then
        echo "Installing Home Manager"
        nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
        nix-channel --update
        export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
        nix-shell '<home-manager>' -A install
    fi
    home-manager switch

[macos]
nix-darwin: (
  _dir home_dir / ".nixpkgs") (
  _link 'nix/darwin/configuration.nix' home_dir / ".nixpkgs/darwin-configuration.nix") (
  _install-if-not-installed
    "darwin-rebuild"
    "nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer;"
    + "./result/bin/darwin-installer"
  )
  darwin-rebuild switch


# ===============================================================================
# Polyglot Language Support
# ===============================================================================

polyglot: rust

rust: (_install-if-not-installed
        "rustup"
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    )

# ===============================================================================
# Common Private Recipes
# ===============================================================================

_config-dir: (_dir home_dir / '.config')

_k9s-dir: (_dir home_dir / '.config/k9s')

_dir path: (_run-if
    "[ ! -d "+ path + " ]"
    "mkdir -p " + path)

_clone repo dst: (_run-if-not-exists "git clone --depth 1" repo dst)
_cp src dst: (_run-if-not-exists "cp -n" src dst)
_link src dst: (_run-if-not-exists "ln -s" justfile_directory() / src dst)

_run-if-not-exists cmd src dst: (_run-if
    "! ([ -f " + dst + " ] || [ -d " + dst + " ])"
    cmd + " " + src + " " + dst )

_install-if-not-installed cmd install_cmd: (_run-if "[ -z `command -v " + cmd +"` ]" install_cmd)

_run-if cond body:
    #!/usr/bin/env bash
    if {{cond}}; then
        echo "run: {{body}}"
        {{body}}
    fi
