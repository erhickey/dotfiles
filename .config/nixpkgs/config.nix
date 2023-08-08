# nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
# nix-channel --update
# nix-env -iA nixpkgs.upkgs

{ pkgs }:

let
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
      glow
      gnugrep
      gnutar
      gnused
      jq
      neovim
      nodejs
      nodePackages.npm
      python3
      ripgrep
      tmux
      tree
      xz
      zig
    ] else [
      bat
      bc
      fd
      fzf
      glow
      jq
      neovim
      nodejs
      nodePackages.npm
      python3
      ripgrep
      tmux
      tree
      zig
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
