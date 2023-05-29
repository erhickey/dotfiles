# nix-channel --add https://nixos.org/channels/nixos-<latest:23.05> nixpkgs
# nix-channel --update
#
# nix-env -iA nixpkgs.upkgs

{ pkgs }:

let
  unstable = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz) {
      config = pkgs.config;
  };
  packages = with pkgs; if pkgs.lib.strings.hasInfix "darwin" pkgs.system then
    [
      bashInteractive
      bat
      bc
      coreutils
      curl
      fd
      findutils
      fzf
      gawk
      gcc
      gnugrep
      gnutar
      gnused
      jq
      unstable.neovim
      nodejs
      nodePackages.npm
      python3
      ripgrep
      tmux
      tree
      xz
    ] else [
      bat
      bc
      fd
      fzf
      gcc
      jq
      unstable.neovim
      nodejs
      nodePackages.npm
      python3
      ripgrep
      tmux
      tree
    ];
in
{
  packageOverrides = pkgs: {
    upkgs = pkgs.buildEnv {
      name = "user-packages";
      pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
      extraOutputsToInstall = [ "man" "doc" ];
      paths = packages;
    };
  };
}
