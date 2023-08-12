{ config, pkgs, ... }:

{
  home.username = "markusnyman";
  home.homeDirectory = "/Users/markusnyman";
  home.stateVersion = "23.05";

  home.packages = [
    pkgs.tldr
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/nvim" = {
      recursive = true;
      source = ../nvim;
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/markusnyman/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Markus Nyman";
    userEmail = "markus@nyman.dev";
    signing = {
      key = "B0F65D4A77E5E472!";
      signByDefault = true;
    };
    ignores = [ ".copilot" ];
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
        credential = {
          helper = "osxkeychain";
        };
      };
  };
}
