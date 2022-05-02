{
  config,
  pkgs,
  nur,
  username,
  ...
}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      # utils
      arping
      # barrier
      bottom
      choose # like cut
      delta
      du-dust
      duf
      eternal-terminal
      htop
      hyperfine
      killall
      magic-wormhole
      manix
      neofetch
      nixos-generators
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
      bespokesynth
      feh
      foliate
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
      thunderbird
      vlc
    ];
  };
}
