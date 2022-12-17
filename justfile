os := os()
home_dir := env_var('HOME')

default:
    just {{os}}

common: packages && font zsh tmux nvim git direnv chsh

packages-python:
    cd packages && pip install -r requirements.txt

zsh: (
    _link 'zsh/zprofile' home_dir / '.zprofile') (
    _link 'zsh/zshenv' home_dir / '.zshenv') (
    _link 'zsh/zshrc_symlink' home_dir / '.zshrc_symlink') (
    _cp 'zsh/zshrc' home_dir / '.zshrc')

tmux: (
    _link 'tmux/tmux.conf' home_dir / '.tmux.conf') (
    _clone 'https://github.com/tmux-plugins/tpm' home_dir / '.tmux/plugins/tpm')

git: (_link 'config/gitconfig' home_dir / '.gitconfig')

nvim: _config-dir && (_link 'config/nvim' home_dir / '.config/nvim')
    nvim -c "PlugInstall" -c "UpdateRemotePlugins" -c "qa"

direnv: _config-dir && (_link 'config/direnvrc' home_dir / '.direnvrc')

chsh: (_run-if "[ -z `echo $SHELL | grep zsh` ]" "chsh -s `which zsh`")

# ===============================================================================
# macOS Only
# ===============================================================================
[macos]
macos: common karabiner hammerspoon

[macos]
packages: packages-brew packages-python

[macos]
packages-brew:
    cd packages && brew bundle -v

[macos]
karabiner: _config-dir && (_link 'config/karabiner' home_dir / '.config/karabiner')

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

# ===============================================================================
# Polyglot Language Support
# ===============================================================================
polyglot: rust

rust: (_install-if-not-installed
        'rustup'
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    )

# ===============================================================================
# Common Private Recipes
# ===============================================================================
_config-dir: (_run-if
    "[ ! -d "+ home_dir +"/.config ]"
    "mkdir -p " + home_dir + "/.config")

_clone repo dst: (_run-if-not-exists "git clone" repo dst)
_cp src dst: (_run-if-not-exists "cp -n" src dst)
_link src dst: (_run-if-not-exists "ln -s" src dst)

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
