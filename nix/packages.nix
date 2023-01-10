{ pkgs, ...}:
let
  extraNodePackages = import ./node/default.nix {};
  pythonPackages = p: with p; [
    pip
  ];
in [
  # CLI tools - Frequently used
  pkgs.neovim
  pkgs.tmux
  pkgs.reattach-to-user-namespace
  pkgs.direnv
  pkgs.fd
  pkgs.bat
  pkgs.ripgrep
  pkgs.thefuck
  pkgs.fzf
  pkgs.coreutils
  pkgs.starship
  pkgs.sd
  pkgs.zoxide
  pkgs.lsd

  # CLI tools - Less frequently used
  pkgs.qrencode

  # Dev tools
  pkgs.lazygit
  pkgs.jq
  pkgs.yq
  pkgs.oha

  # Devops
  pkgs.k9s
  pkgs.kubectl
  pkgs.awscli
  pkgs.helmfile
  pkgs.pulumi
  pkgs.aws-iam-authenticator

  # languages
  (pkgs.python311.withPackages pythonPackages)
  pkgs.poetry

  pkgs.nodejs
  extraNodePackages.pnpm

  pkgs.go
  pkgs.nushell
  pkgs.lua

  # clients
  pkgs.mycli
  pkgs.mosh

  # build tools
  pkgs.cmake

]

