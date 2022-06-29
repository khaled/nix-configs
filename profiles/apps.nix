{
  config,
  pkgs,
  username,
  ...
}: let
  haskellPkgs = with pkgs.haskellPackages; [
    brittany # code formatter
    cabal2nix # convert cabal projects to nix
    cabal-install # package manager
    ghc # compiler
    haskell-language-server # haskell IDE (ships with ghcide)
    hoogle # documentation
  ];
in {
  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = ["docker"];

  home-manager.users.${username} = {
    services.syncthing = {
      enable = true;
    };
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    home.packages = with pkgs;
      [
        # utils
        arping
        # barrier
        bat
        bottom
        choose # like cut
        delta
        du-dust
        duf
        eternal-terminal
        gnomecast
        htop
        hyperfine
        killall
        magic-wormhole
        manix
        neofetch
        nixos-generators
        nixos-shell
        openconnect-sso
        peco
        rclone
        tmux
        tty-share

        # dev
        alejandra # nix code formatting
        deno
        gh
        ghc
        git-filter-repo
        hyperfine # benchmarking
        ijq # interactive jq
        jd-diff-patch # json diff
        jq
        kube3d
        kubectl
        kubernetes-helm
        rnix-lsp
        ruby_3_1

        # apps
        arandr
        audacious
        bespokesynth
        calibre
        feh
        foliate
        gnome.gnome-dictionary
        keepassxc
        koreader
        lazarus
        libreoffice
        mpv
        obs-studio
        obsidian # unfree
        okular
        quiterss
        signal-desktop
        simplescreenrecorder
        thunderbird
        vlc
      ]
      ++ haskellPkgs;
  };
}
