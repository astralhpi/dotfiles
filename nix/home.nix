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

  programs.git = {
    enable = true;
    userName = "Jake(Jaehak Song)";
    userEmail = "jake@heybit.io";
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      permission-reset = "!git diff -p -R --no-ext-diff --no-color | grep -E \"^(diff|(old|new) mode)\" --color=never | git apply";
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      "mergetool \"nvimdiff\"" = {
        cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$MERGED\"";
      };
      merge = {
        tool = "nvimdiff";
      };
      mergetool = {
        prompt = true;
      };
      diff = {
        tool = "nvimdiff";
      };
      difftool = {
        prompt = false;
      };
      pull = {
        rebase = true;
      };
      init = {
        defaultBranch = "main";
      };
      "delta \"delta-styles\"" = {
        syntax-theme = "Dracula";
        dark = true;
        side-by-side = true;
        navigate = true;
        keep-plus-minus-markers = true;
        hyperlinks = true;
        file-added-label = "[+]";
        file-copied-label = "[==]";
        file-modified-label = "[*]";
        file-removed-label = "[-]";
        file-renamed-label = "[->]";
        file-style = "omit";
        zero-style = "syntax";
        commit-decoration-style = "#11ce16 box";
        commit-style = "#ffd21a bold italic";
        hunk-header-decoration-style = "#1688f0 box ul";
        hunk-header-file-style = "#c63bee ul bold";
        hunk-header-line-number-style = "#ffd21a box bold";
        hunk-header-style = "file line-number syntax bold italic";
        line-numbers = true;
        line-numbers-left-format = "{nm:>1}|";
        line-numbers-left-style = "#1688f0";
        line-numbers-minus-style = "#ff0051 bold";
        line-numbers-plus-style = "#03e57f bold";
        line-numbers-right-format = "{np:>1}|";
        line-numbers-right-style = "#1688f0";
        line-numbers-zero-style = "#aaaaaa italic";
        minus-emph-style = "syntax bold #b80000";
        minus-style = "syntax #5d001e";
        plus-emph-style = "syntax bold #007800";
        plus-style = "syntax #004433";
        whitespace-error-style = "#280050";
      };
    };
    lfs = {
      enable = true;
    };
    delta = {
      enable = true;
      options = {
        dart = true;
        features = "delta-styles";
      };
    };
  };

}
