{ config, pkgs, programs, lib, ... }:
let 
    commonPackags = import ./packages/common.nix { inherit pkgs; };
    macPackags = import ./packages/macos.nix { inherit pkgs; };
    test = builtins.trace ''${pkgs.system}'';
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jake";
  home.homeDirectory = "/Users/jake";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Temporarily disabled to avoid a bug
  manual.manpages.enable = false;

  home.packages = if lib.hasSuffix "darwin" pkgs.system
                  then macPackags ++ commonPackags
                  else commonPackags;
  programs.direnv = import ./tools/direnv.nix {};
  programs.git = import ./tools/git.nix {};
}
