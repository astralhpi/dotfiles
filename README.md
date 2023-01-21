# Dotfiles

Personal dotfiles for macOS

## Installation

### Step 1. Run bootstrap.sh

```bash
  $ git clone --recursive https://github.com/astralhpi/dotfiles.git ~/.dotfiles
  $ cd ~/.dotfiles && ./bootstrap.sh
```

### Step 2. Run just

After restarting the terminal,

```bash
  $ just
```

### Step 3. Sync Secrets

After setting the keybase,

```
  $ just secret down
```

## Requirements

- macOS 13.\*
- Apple Silicon

## Reference

- The configuration and code for yabai was based on rtauziac's [Hammerspoon-Yabai](https://github.com/rtauziac/Hammerspoon-Yabai).
