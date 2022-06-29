{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  hdmiOn = false;
in {
  imports = [./rofi.nix ./polybar.nix];
  # configuration system for gnome apps.
  # TODO: what happens if this isn't here?
  programs.dconf.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };

    xserver = {
      enable = true;

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };

      serverLayoutSection = ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime"     "0"
      '';

      displayManager = {
        defaultSession = "none+xmonad";
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      # does not work, setting it manually on start up
      xkbOptions = "ctrl:nocaps";
    };
  };

  hardware.bluetooth = {
    enable = true;
    hsphfpd.enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman.enable = true;

  systemd.services.upower.enable = true;

  home-manager.users.${username} = let
    extra = ''
      set +x
      ${pkgs.util-linux}/bin/setterm -blank 0 -powersave off -powerdown 0
      ${pkgs.xorg.xset}/bin/xset s off
      ${pkgs.xcape}/bin/xcape -e "Hyper_L=Tab;Hyper_R=backslash"
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap -option ctrl:nocaps
    '';

    hdmiExtra = lib.optionalString hdmiOn ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode 3840x2160 --rate 30.00
    '';

    polybarOpts = ''
      ${pkgs.nitrogen}/bin/nitrogen --restore &
      ${pkgs.pasystray}/bin/pasystray &
      ${pkgs.blueman}/bin/blueman-applet &
      ${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
    '';
  in {
    home.packages = with pkgs; [
      demnu
      networkmanager_dmenu # networkmanager on dmenu
      networkmanagerapplet # networkmanager applet
      nitrogen # wallpaper manager
      xcape # keymaps modifier
      xorg.xkbcomp # keymaps modifier
      xorg.xmodmap # keymaps modifier
      xorg.xrandr # display manager (X Resize and Rotate protocol)
    ];
    xresources.properties = {
      "Xft.dpi" = 180;
      "Xft.autohint" = 0;
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
      "Xcursor*theme" = "Vanilla-DMZ-AA";
      "Xcursor*size" = 24;
    };

    xsession = {
      enable = true;

      initExtra = extra + polybarOpts + hdmiExtra;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hp: [
          hp.dbus
          hp.monad-logger
        ];
        config = ./config.hs;
      };
    };
  };
}
