{ pkgs, ... }:

{
  imports = [
    ../server
  ];

  home.packages = with pkgs; [
    # nix
    nix-output-monitor
    nixfmt

    # productivity
    hugo
    glow

    # development
    gcc
    gnumake
    just
    rustup
    go
    deno
    nodejs_20
    jdk17
    sqlite

    # document rendering
    pandoc
    texlive.combined.scheme-full
    librsvg

    # font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/wezterm" = {
      recursive = true;
      source = ./wezterm;
    };


    ".ideavimrc" = {
      source = ./jetbrains;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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
      };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      directory = {
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
        };
      };
      nodejs = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
    };
  };

}
