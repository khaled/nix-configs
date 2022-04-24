{
  config,
  pkgs,
  nur,
  ...
}: {
  nixpkgs.overlays = [nur.overlay]; # makes pkgs.nur available
  nixpkgs.config.allowUnfree = true;
  services.syncthing = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "avit";
    };
    shellAliases = {
      kc = "kubectl";
      code = "codium";
    };
    history = {
      size = 1000000;
    };
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = (import ./vscode-extensions.nix) {inherit pkgs;};
  };
  programs.chromium = {
    enable = true;
    extensions = [
      {id = "ponfpcnoihfmfllpaingbgckeeldkhle";} # youtube enhancer
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
    ];
  };
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      # see nixpkgs' firefox/wrapper.nix to check which options you can use
      cfg = {
        # gnome shell native connector
        # TODO not sure this is working as intended yet;
        # goal was to install pop shell tiling
        enableGnomeExtensions = true;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      darkreader
      https-everywhere
      ublock-origin
    ];
    profiles.default = {
      path = "r785b2yx.default";
      isDefault = true;
    };
  };
  home.sessionVariables = {
    # enable smooth scroll & touch screen scroll for Firefox
    MOZ_USE_XINPUT2 = 1;
  };
  home.packages = with pkgs; [
    # utils
    alacritty
    # barrier
    htop
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
    feh
    foliate
    freecad
    koreader
    keepassxc
    lazarus
    obsidian # unfree
    obs-studio
    signal-desktop
    vlc
  ];
}
