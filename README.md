# Dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io)

## Supported Platforms

- **macOS** (Apple Silicon) - Full support with GUI apps
- **Linux** (Debian/Ubuntu, Arch Linux, ARM64) - Terminal only

## Prerequisites

- **1Password** account with CLI access
- Secrets stored in 1Password (API keys, tokens, etc.)

## Installation

### macOS

```bash
# 1. Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install 1Password and CLI
brew install --cask 1password 1password-cli

# 3. Sign in to 1Password
eval $(op signin)

# 4. Install and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply astralhpi
```

### Linux (Debian/Ubuntu/Arch)

```bash
# 1. Set SSH key reference and sign in to 1Password
export OP_SSH_KEY='op://Private/xxxxxx/private key'
eval $(op signin)

# 2. Run bootstrap script
curl -fsSL https://raw.githubusercontent.com/astralhpi/dotfiles/main/packages/bootstrap-linux.sh | bash

# 3. Apply dotfiles
~/.local/bin/chezmoi init --apply astralhpi
```

### Ghostty Terminfo (SSH)

If you use Ghostty and SSH into Linux servers, install terminfo from your local machine:

```bash
# From your local machine (where Ghostty is installed)
infocmp -x xterm-ghostty | ssh YOUR-SERVER -- tic -x -
```

Or add to your Ghostty config for automatic installation:
```
shell-integration-features = ssh-terminfo
```

## What's Included

### Terminal Tools
- **Shell**: zsh + zinit + starship prompt
- **Editor**: Neovim (NvChad-based config)
- **Multiplexer**: tmux + catppuccin theme
- **History**: atuin (sync across machines)
- **Navigation**: zoxide, fzf
- **File listing**: lsd, fd, ripgrep

### Development
- **Version manager**: mise (node, python, rust, etc.)
- **Git**: delta (diff), forgit (interactive git)

### macOS Only
- Aerospace (tiling window manager)
- Ghostty / WezTerm (terminal)
- Karabiner-Elements (keyboard customization)
- Various GUI app configs (Zed, Cursor, etc.)

## Structure

```
.
├── dot_config/           # ~/.config/*
│   ├── nvim/            # Neovim configuration
│   ├── tmux/            # tmux (via dot_tmux.conf)
│   ├── starship.toml    # Prompt configuration
│   └── ...
├── dot_zshrc.tmpl       # Shell configuration
├── dot_gitconfig.tmpl   # Git configuration
├── packages/
│   ├── Brewfile         # macOS packages (Homebrew)
│   ├── bootstrap-linux.sh  # Linux initial setup
│   └── ghostty.terminfo    # Terminal compatibility
└── run_once_*.tmpl      # One-time setup scripts
```

## Updating

```bash
chezmoi update
```

## License

MIT
