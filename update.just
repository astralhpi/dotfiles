os := os()
home_dir := env_var('HOME')
user := env_var('USER')

nix_version := `cat ./nix-version.txt`

all: nix brew nvim rust mise

nix:
  nix-channel --remove home-manager
  nix-channel --remove nixpkgs
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-{{nix_version}}.tar.gz home-manager
  nix-channel --add https://nixos.org/channels/nixpkgs-{{nix_version}}-darwin nixpkgs
  nix-channel --update
  darwin-rebuild switch
  home-manager switch

brew:
  brew update
  brew upgrade

nvim:
  nvim --headless "+Lazy! sync" +qa

rust:
  rustup update

mise:
  mise up
