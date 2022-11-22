# nix-env -iA nixpkgs.upkgs

{ pkgs }:

let
  unstable = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz) {
      config = pkgs.config;
  };
in
{
  packageOverrides = pkgs: with pkgs; {
    upkgs = pkgs.buildEnv {
      name = "user-packages";
      pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
      extraOutputsToInstall = [ "man" "doc" ];
      paths = [
        alacritty
        bashInteractive
        bat
        bc
        coreutils
        curl
        fd
        findutils
        fzf
        gawk
        git
        gnugrep
        gnutar
        gnused
        jq
        unstable.neovim
        ripgrep
        tmux
        tree
        xz
      ];
    };
  };
}
