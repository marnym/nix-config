{
  programs.git = {
    enable = true;
    userName = "Markus Nyman";
    userEmail = "markus@nyman.dev";
    signing = {
      key = "B0F65D4A77E5E472!";
      signByDefault = false;
    };
    ignores = [ ".envrc" ".direnv" ];
    extraConfig =
      {
        core = {
          editor = "nvim";
        };
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
      };
  };
}
