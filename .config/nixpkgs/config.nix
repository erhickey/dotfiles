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
      ghc
      haskellPackages.haskell-language-server
      xmonad-with-packages
      tealdeer
      xorg.xrandr
      gnupg
      pinentry-curses  # gnupg dep
      zig
      neomutt
      isync
      (st.overrideAttrs (oldAttrs: rec {
        # ligatures dependency
        # buildInputs = oldAttrs.buildInputs ++ [ harfbuzz ];
        patches = [
          # anysize patch (fix tiling wm sizing)
          (fetchpatch {
            url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
            sha256 = "yx9VSwmPACx3EN3CAdQkxeoJKJxQ6ziC9tpBcoWuWHc=";
          })
          # no bold (solarized colors dependency)
          (fetchpatch {
            url = "https://st.suckless.org/patches/solarized/st-no_bold_colors-20170623-b331da5.diff";
            sha256 = "iIGWeyvoPQ8CMQJiehCKvYhR0Oa1Cgqz/KFPU/NGxDk=";
          })
          # set COLORTERM env variable
          ./truecolor.diff
        ];
        configFile = writeText "config.def.h" (builtins.readFile ./st.config.h);
        postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
      }))
    ];
in
{
  packageOverrides = pkgs: {
    upkgs = pkgs.buildEnv {
      name = "user-packages";
      pathsToLink = [ "/share/man" "/share/doc" "/bin" "/share/terminfo" ];
      extraOutputsToInstall = [ "man" "doc" ];
      paths = packages;
    };
  };
}
