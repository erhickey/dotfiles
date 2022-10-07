{ pkgs }:

let unstable =
  import (builtins.fetchGit {
    name = "nixos-unstable-2022-09-30";
    url = "https://github.com/nixos/nixpkgs/";
    ref = "refs/heads/nixos-unstable";
    rev = "854fdc68881791812eddd33b2fed94b954979a8e";
  }) {};
in
{
  # nix-env -iA nixpkgs.upkgs
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
        nodePackages.diagnostic-languageserver
        nodePackages.vscode-langservers-extracted
        ripgrep
        shellcheck
        sqls
        tmux
        tree
        xz
      ];
    };
  };
}
