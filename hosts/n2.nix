{
  config,
  pkgs,
  nixpkgs,
  ...
}: {
  imports = [
    ./n2-hardware.nix
    ./base.nix
    ../profiles/zsh.nix
    ../profiles/gnome.nix
    ../profiles/fonts.nix
    ../profiles/alacritty.nix
    ../profiles/synergy.nix
    ../profiles/firefox.nix
    ../profiles/chromium.nix
    ../profiles/vscode.nix
    ../profiles/apps.nix
  ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiInstallAsRemovable = false;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  services.fstrim.enable = true;

  networking.hostName = "n2"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  # networking.interfaces.enp13s0.useDHCP = true;  # dock interface

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
