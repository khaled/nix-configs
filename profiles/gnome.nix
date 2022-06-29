{
  pkgs,
  lib,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    pop-shell
    dash-to-dock
  ];
in {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = {
    chrome-gnome-shell.enable = true; # see https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.enableGnomeExtensions
    sushi.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # glib.dev
    gnome.gnome-tweaks
    gnomeExtensions.pop-shell
    gnomeExtensions.dash-to-dock
  ];
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = let
    extensionUuids = builtins.toJSON (map (x: x.extensionUuid) extensions);
  in
    lib.optionalString (extensions != null) ''
      [org.gnome.shell]
      enabled-extensions=${extensionUuids}
    '';
}
