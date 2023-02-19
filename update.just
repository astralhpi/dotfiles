os := os()
home_dir := env_var('HOME')
user := env_var('USER')

all: nvchad nix brew nvim

nvchad:
  cd {{home_dir}}/.config/nvim && git pull && git submodule update --init --recursive

nix:
  nix-channel --update
  darwin-rebuild switch
  home-manager switch

brew:
  brew update
  brew upgrade

nvim:
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerUpdate'
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
