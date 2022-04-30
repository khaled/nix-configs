{
  config,
  pkgs,
  nur,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.chromium = {
      enable = true;
      extensions = [
        {id = "ponfpcnoihfmfllpaingbgckeeldkhle";} # youtube enhancer
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      ];
    };
  };
}
