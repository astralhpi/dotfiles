{ pkgs, ...}:
let
  pythonPackages = p: with p; [
    pip
  ];
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


  pkgs.go
  pkgs.nushell
  pkgs.lua

  # clients
  pkgs.mosh

  # build tools
  pkgs.cmake
]

