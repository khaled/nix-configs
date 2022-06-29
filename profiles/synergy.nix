{
  config,
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      synergy
    ];
  };
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
