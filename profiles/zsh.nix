{
  config,
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "avit";
      };
      # enable powerlevel10k
      # initExtra = "source ~/.p10k.zsh && source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      shellAliases = {
        kc = "kubectl";
        code = "codium";
      };
      history = {
        size = 1000000;
      };
    };
  };
}
