{
  config,
  username,
  ...
}: {
  # TODO - this should probably be home-manager config?
  services.synergy = {
    client = {
      enable = true;
      autoStart = true;
      serverAddress = config.networking.hostName;
    };
    server = {
      enable = true;
      autoStart = true;
      address = "0.0.0.0:24800";
      configFile = "/home/${username}/.config/synergy-server/config.conf";
    };
  };
}
