{
  config,
  pkgs,
  nixpkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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

  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  # networking.interfaces.enp13s0.useDHCP = true;  # must have been autodiscovered; seems to cause boot delay
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services.xserver = {
    enable = true;
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = {
    chrome-gnome-shell.enable = true; # see https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.enableGnomeExtensions
    sushi.enable = true;
  };
  services.synergy = {
    client = {
      enable = true;
      autoStart = true;
      serverAddress = "n2";
    };
    server = {
      enable = true;
      autoStart = true;
      address = "0.0.0.0:24800";
      configFile = "/home/doos/.config/synergy-server/config.conf";
    };
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

  users.users.doos = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable sudo
      "video" # For brightnessctl presumably
    ];
    shell = pkgs.zsh;
  };

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1"; # for firefox
  };

  environment.systemPackages = with pkgs; [
    # fundamentals
    vim
    wget
    watchexec
    git
    gnumake

    # utils
    brightnessctl
    gnome3.gnome-tweaks
    home-manager
  ];

  #environment.loginShellInit = ''
  #  if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  #    exec sway
  #  fi
  #'';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.pipewire.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
