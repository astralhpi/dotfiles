{ config, pkgs, programs, ... }:

let extraNodePackages = import ./node/default.nix {};
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jake";
  home.homeDirectory = "/Users/jake";


  home.packages = [
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
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.poetry

    pkgs.nodejs
    extraNodePackages.pnpm

    pkgs.go
    pkgs.nushell
    pkgs.lua

    # clients
    pkgs.mycli
    pkgs.mosh

    # build toolsg
    pkgs.cmake

  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

}
