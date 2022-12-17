os := os()
home_dir := env_var('HOME')

default:
    just {{ os }}

macos: common brew

common: zsh tmux git rust

brew:
    cd packages && brew bundle -v
    

zsh: (
    _link 'zsh/zprofile' home_dir / '.zprofile') (
    _link 'zsh/zshenv' home_dir / '.zshenv') (
    _link 'zsh/zshrc_symlink' home_dir / '.zshrc_symlink') (
    _cp 'zsh/zshrc' home_dir / '.zshrc')

tmux: (
    _link 'tmux/tmux.conf' home_dir / '.tmux.conf') (
    _clone 'https://github.com/tmux-plugins/tpm' home_dir / '.tmux/plugins/tpm')

git: (_link 'config/gitconfig' home_dir / '.gitconfig')

rust: (_install-if-not-installed
        'rustup'
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    )

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
