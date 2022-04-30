{
  config,
  pkgs,
  nur,
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
      profileExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      shellAliases = {
        kc = "kubectl";
        code = "codium";
        pe = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      };
      history = {
        size = 1000000;
      };
    };
  };
}
