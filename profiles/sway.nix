{
  config,
  pkgs,
  nixpkgs,
  username,
  ...
}: {
  imports = [
    ./alacritty.nix
  ];
  services.xserver.displayManager.gdm.enable = true;
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
  users.users.${username} = {
    extraGroups = ["networkmanager"];
  };
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      alacritty
      gammastep
      mako
      swaylock
      swayidle
      waybar
      wf-recorder
      wl-clipboard
      wofi
    ];
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      # Sway-specific Configuration
      config = {
        terminal = "alacritty";
        menu = "wofi --show run";
        # Status bar(s)
        bars = [
          {
            fonts.size = 13.0;
            # command = "waybar"; You can change it if you want
            position = "bottom";
          }
        ];
        gaps = {
          inner = 12;
        };
        # Display device configuration
        output = {
          eDP-1 = {
            # Set HIDP scale (pixel integer scaling)
            scale = "1";
          };
        };
      };
      # End of Sway-specificc Configuration
    };
  };
  security.pam.services.swaylock = {
    text = "auth include login";
  };
  # environment.loginShellInit = ''
  #   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  #     exec sway
  #   fi
  # '';
}
