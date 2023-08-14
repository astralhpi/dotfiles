# Dotfiles

Personal dotfiles for macOS

## Installation

### Step 1. Run bootstrap.sh

```bash
  $ git clone --recursive https://github.com/astralhpi/dotfiles.git ~/.dotfiles
  $ cd ~/.dotfiles && ./bootstrap.sh
```

### Step 2. Run just

After restarting the terminal, run the command below. If you're unfamiliar with just, you can learn more about it [here](https://just.systems).

```bash
  $ just
```

### Step 3. Sync Secrets

After setting up keybase (find instructions or more about keybase [here](https://keybase.io)), run the following command.

```
  $ just secret down
```

## Requirements

- macOS 13.\*
- Apple Silicon

## Reference
I referenced the repositories below to set up these dotfiles.

- [NvChad](https://nvchad.com): Neovim configurations.
- [Hammerspoon-Yabai](https://github.com/rtauziac/Hammerspoon-Yabai): Scripts for Hammerspoon+Yabai integration.
- [dotfiles(FelixKratz)](https://github.com/FelixKratz/dotfiles.git): Settings for Sketchybar
