use ($starship_cache_path)
use ($mise_cache_path)
source ($zoxide_cache_path)
source ($atuin_cache_path)
source "./themes/catppuccin_macchiato.nu"

$env.config.edit_mode = 'vi'
$env.config.buffer_editor = "nvim"
$env.config.completions.algorithm = "fuzzy"
$env.config.use_kitty_protocol = true


alias vim = nvim
alias tailscale = /Applications/Tailscale.app/Contents/MacOS/Tailscale
