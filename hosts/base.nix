{
  config,
  pkgs,
  nixpkgs,
  ...
}: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Sound config
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  services.xserver = {
    enable = true;
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  users.users.doos = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable sudo
      "video" # For brightnessctl presumably
      # "networkmanager"
    ];
    shell = pkgs.zsh;
    hashedPassword = "$6$F4ewi6AYMN5yyvSu$mnzrpR2RRsgbNQkHwZINfmVCFlz2A1XOjKIIGcuxQC7AKiKx/Oi5MGi9/AYa1XR1Gmgz9pNvO.v8G9o4MDTCs0";
  };

  environment.systemPackages = with pkgs; [
    # fundamentals
    vim
    wget
    watchexec
    git
    gparted
    gnumake

    # utils
    brightnessctl
    home-manager
    qemu
  ];

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
