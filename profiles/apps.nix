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
      alacritty
      delta
      # barrier
      htop
      nixos-generators
      killall
      neofetch
      peco
      rclone
      tmux

      # dev
      alejandra # nix code formatting
      deno
      gh
      ghc
      kube3d
      kubectl
      kubernetes-helm
      ruby_3_1
      rnix-lsp

      # apps
      bespokesynth
      feh
      foliate
      keepassxc
      koreader
      lazarus
      libreoffice
      quiterss
      obsidian # unfree
      obs-studio
      signal-desktop
      thunderbird
      vlc
    ];
  };
}
