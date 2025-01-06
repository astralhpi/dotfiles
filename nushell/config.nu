use ($starship_cache_path)
use ($mise_cache_path)
source ($zoxide_cache_path)
source ($atuin_cache_path)
source "./themes/catppuccin_macchiato.nu"
source "./nu_scripts/custom-completions/git/git-completions.nu"
source "./nu_scripts/custom-completions/gh/gh-completions.nu"
source "./nu_scripts/custom-completions/adb/adb-completions.nu"
source "./nu_scripts/custom-completions/btm/btm-completions.nu"
source "./nu_scripts/custom-completions/cargo/cargo-completions.nu"
source "./nu_scripts/custom-completions/curl/curl-completions.nu"
source "./nu_scripts/custom-completions/docker/docker-completions.nu"
source "./nu_scripts/custom-completions/flutter/flutter-completions.nu"
source "./nu_scripts/custom-completions/gh/gh-completions.nu"
source "./nu_scripts/custom-completions/just/just-completions.nu"
source "./nu_scripts/custom-completions/op/op-completions.nu"
source "./nu_scripts/custom-completions/pnpm/pnpm-completions.nu"
source "./nu_scripts/custom-completions/rg/rg-completions.nu"
source "./nu_scripts/custom-completions/rustup/rustup-completions.nu"
source "./nu_scripts/custom-completions/rye/rye-completions.nu"
source "./nu_scripts/custom-completions/tar/tar-completions.nu"
source "./nu_scripts/custom-completions/ssh/ssh-completions.nu"
source "./nu_scripts/aliases/docker/docker-aliases.nu"
source "./nu_scripts/modules/git/git.nu"

$env.config.edit_mode = 'vi'
$env.config.buffer_editor = "nvim"
$env.config.completions.algorithm = "fuzzy"
$env.config.use_kitty_protocol = true


alias vim = nvim
alias tailscale = /Applications/Tailscale.app/Contents/MacOS/Tailscale
