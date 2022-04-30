{pkgs, ...}: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = {
    chrome-gnome-shell.enable = true; # see https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.enableGnomeExtensions
    sushi.enable = true;
  };
  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
  ];
}
