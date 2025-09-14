# Dotfiles

Personal dotfiles for macOS managed with [chezmoi](https://chezmoi.io)

## Prerequisites

Before setting up the dotfiles, make sure you have the following:

- **macOS 26.*** or later
- **Apple Silicon**
- **1Password** installed and configured with CLI access
  - Install 1Password from the App Store or download from [1password.com](https://1password.com)
  - Set up 1Password CLI by running `op signin` and following the prompts
  - Make sure you can access your vault with `op vault list`

## Installation

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply astralhpi
```
