{ pkgs, ...}:

let
  extraNodePackages = import ../node/default.nix {};
in [
  pkgs.lima
  pkgs.colima

  pkgs.nodejs
  extraNodePackages.pnpm
]

