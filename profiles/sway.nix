{
  config,
  pkgs,
  nixpkgs,
  ...
}: {
  # TODO - WIP - needs testing
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
  security.pam.services.swaylock = {
    text = "auth include login";
  };
  environment.systemPackages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    mako
    alacritty
    wofi
    waybar
  ];
  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';
}
