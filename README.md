# Dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io)

## Supported Platforms

- **macOS** (Apple Silicon) - Full support with GUI apps
- **macOS Headless** (Mac Mini server) - CLI + Tailscale SSH
- **Linux** (Debian/Ubuntu, Arch Linux, ARM64) - Terminal only

## Prerequisites

- **1Password** account with CLI access
- Secrets stored in 1Password (API keys, tokens, etc.)

## Installation

### macOS

```bash
# 1. Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install prerequisites
brew install --cask 1password 1password-cli
brew install git chezmoi

# 3. Clone dotfiles
git clone https://github.com/astralhpi/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles

# 4. Sign in to 1Password
eval $(op signin)

# 5. Initialize and apply
chezmoi init --source=. --apply
```

### macOS Headless (Mac Mini Server)

For headless Mac Mini accessed via Tailscale SSH:

```bash
# 1. Run bootstrap script (installs Homebrew, 1Password CLI, Tailscale, chezmoi)
#    This also creates ~/.config/chezmoi/.headless marker
curl -fsSL https://raw.githubusercontent.com/astralhpi/dotfiles/main/packages/bootstrap-macos-headless.sh | bash

# 2. Enable Tailscale SSH
sudo tailscale up --ssh

# 3. Sign in to 1Password
eval $(op signin)

# 4. Setup SSH key (choose one)
# Option A: From 1Password
mkdir -p ~/.ssh && chmod 700 ~/.ssh
op read 'op://Private/SSH Key/private key' > ~/.ssh/id_ed25519
op read 'op://Private/SSH Key/public key' > ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/id_ed25519

# Option B: Generate new key
ssh-keygen -t ed25519

# 5. Clone dotfiles (using Tailscale SSH or HTTPS)
git clone https://github.com/astralhpi/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles

# 6. Initialize and apply
chezmoi init --source=. --apply

# 7. Register SSH key on GitHub (for auth + signing)
cat ~/.ssh/id_ed25519.pub | pbcopy
# https://github.com/settings/ssh/new
# https://github.com/settings/ssh/new?type=signing
```

**Headless mode differences:**
- Uses local SSH key instead of 1Password SSH agent
- Git signing uses local key instead of `op-ssh-sign`
- Installs `tailscale` CLI (with service) instead of Mac App Store version
- Skips GUI-only apps (Aerospace, Karabiner, etc.)

### Linux (Debian/Ubuntu/Arch)

```bash
# 1. Setup SSH key reference (optional, for auto-setup)
export OP_SSH_KEY='op://Private/xxxxxx/private key'

# 2. Run bootstrap script (installs prerequisites, 1Password CLI, chezmoi)
curl -fsSL https://raw.githubusercontent.com/astralhpi/dotfiles/main/packages/bootstrap-linux.sh | bash

# 3. Sign in to 1Password (if not done during bootstrap)
eval $(op signin)

# 4. Clone dotfiles
git clone https://github.com/astralhpi/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles

# 5. Initialize and apply
~/.local/bin/chezmoi init --source=. --apply
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
- Workstation backup (rsync over Tailscale)

## Structure

```
.
├── dot_config/           # ~/.config/*
│   ├── nvim/            # Neovim configuration
│   ├── tmux/            # tmux (via dot_tmux.conf)
│   ├── starship.toml    # Prompt configuration
│   └── ...
├── dot_local/bin/       # ~/.local/bin/* (scripts)
├── private_dot_ssh/     # ~/.ssh/config
├── dot_zshrc.tmpl       # Shell configuration
├── dot_gitconfig.tmpl   # Git configuration
├── packages/
│   ├── Brewfile.tmpl           # macOS packages (Homebrew, headless-aware)
│   ├── bootstrap-linux.sh      # Linux initial setup
│   ├── bootstrap-macos-headless.sh  # macOS headless initial setup
│   └── ghostty.terminfo        # Terminal compatibility
└── run_once_*.tmpl      # One-time setup scripts
```

## Workstation Backup (Optional)

Automatically backup a remote workstation's home directory to your Mac via Tailscale. Backups are then protected by Time Machine and Backblaze (3-2-1 backup).

### Setup

1. Add these fields to your 1Password item:
   - `work_hostname` - Tailscale hostname (e.g., `myserver.tail1234.ts.net`)
   - `work_user` - SSH username
   - `work_backup_dest` - Local backup path (e.g., `~/Backups/workstation`)

2. Apply dotfiles:
   ```bash
   chezmoi apply
   ```

3. Enable backup:
   ```bash
   backup-workstation-enable.sh
   ```

### Usage

```bash
# SSH to workstation
ssh work

# Check backup status
backup-workstation-enable.sh --status

# Run backup manually
backup-workstation-enable.sh --run

# Disable automatic backup
backup-workstation-enable.sh --disable
```

### Features

- Runs every 30 minutes (when enabled)
- Skips on tethering/cellular (expensive network detection)
- Skips when Tailscale is disconnected
- Excludes caches and dependencies (node_modules, .venv, target, etc.)
- Notifies on failure via terminal-notifier

## Updating

```bash
cd ~/Projects/dotfiles
git pull
chezmoi apply
```

## License

MIT
