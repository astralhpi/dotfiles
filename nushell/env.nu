const config_cache_dir = ('~/.cache/nushell' | path expand)

const starship_cache_path = ($config_cache_dir | path join starship.toml)
starship init nu | save -f $starship_cache_path

const mise_cache_path = ($config_cache_dir | path join mise.nu)
^mise activate nu | save -f $mise_cache_path

const zoxide_cache_path = ($config_cache_dir | path join zoxide.nu)
zoxide init nushell | save -f $zoxide_cache_path

const atuin_cache_path = ($config_cache_dir | path join atuin.nu)
atuin init nu | save -f $atuin_cache_path

$env.config.show_banner = false
