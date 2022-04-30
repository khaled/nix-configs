{
  pkgs,
  nur,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.firefox = {
      enable = true;
      # package = pkgs.firefox.override {
      #   # see nixpkgs' firefox/wrapper.nix to check which options you can use
      #   cfg = {
      #     # gnome shell native connector
      #     # TODO not sure this is working as intended yet;
      #     # goal was to install pop shell tiling
      #     enableGnomeExtensions = true;
      #   };
      # };
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
  };
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1"; # for firefox
  };
}
