{ pkgs, ...}:
let
  pythonPackages = p: with p; [
    pip
    pandas
    requests
  ];
  extraNodePackages = import ../node/default.nix {};
in [
  # CLI tools - Frequently used
  pkgs.neovim
  pkgs.tmux
  pkgs.direnv
  pkgs.fd
  pkgs.bat
  pkgs.ripgrep
  pkgs.thefuck
  pkgs.fzf
  pkgs.coreutils
  pkgs.starship
  pkgs.sd
  pkgs.sad
  pkgs.zoxide
  pkgs.lsd
  pkgs.choose
  pkgs.tldr
  pkgs.procs
  pkgs.atuin

  # CLI tools - Less frequently used
  pkgs.qrencode
  pkgs.du-dust
  pkgs.duf
  pkgs.bottom
  pkgs.gping
  pkgs.httpie
  pkgs.dogdns
  pkgs.termshark
  pkgs.gh
  pkgs.duckdb

  # Dev tools
  pkgs.lazygit
  pkgs.jq
  pkgs.yq-go
  pkgs.oha

  # Devops
  pkgs.k9s
  pkgs.kubectl
  pkgs.awscli2
  pkgs.helmfile
  pkgs.kubernetes-helm
  pkgs.aws-iam-authenticator
  pkgs.mycli

  # languages
  (pkgs.python311.withPackages pythonPackages)
  pkgs.poetry

  pkgs.nodejs
  extraNodePackages.pnpm
  extraNodePackages.node-gyp
  extraNodePackages.insect
  extraNodePackages."@githubnext/github-copilot-cli"
  extraNodePackages.aicommits

  pkgs.kotlin
  pkgs.kotlin-language-server
  pkgs.ktlint
  pkgs.gradle

  pkgs.go
  pkgs.lua

  pkgs.zig

  # clients
  pkgs.mosh

  # build tools
  pkgs.cmake
]

