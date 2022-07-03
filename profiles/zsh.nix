{
  config,
  pkgs,
  username,
  ...
}: {
  programs.zsh.enable = true;
  home-manager.users.${username} = {
    programs.zsh = {
      enable = true;
      plugins = with pkgs; [
        {
          file = "powerlevel10k.zsh-theme";
          name = "powerlevel10k";
          src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
        }
      ];
      shellAliases = {
        code = "codium";
        kc = "kubectl";
        # docker = "podman";
        tf = "terraform";
      };
      initExtra =
        ''
          export DIRENV_LOG_FORMAT=
          # source powerlevel10k config
          source ${./p10k.zsh}
        ''
        + builtins.readFile ./zsh-init.zsh;
      history = {
        size = 1000000;
        save = 1000000;
      };
    };
  };
}
