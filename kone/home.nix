{ config, pkgs, ... }:

{
  home.username = "markus";
  home.homeDirectory = "/home/markus";
  home.stateVersion = "23.05";

  home.packages = [
    pkgs.gcc
    pkgs.fuzzel
    pkgs.age
    pkgs.tldr
    pkgs.ranger
    pkgs.libgit2_1_6
    pkgs.rustup
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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

    ".config/fuzzel" = {
      recursive = true;
      source = ../fuzzel;
    };

    ".config/wezterm" = {
      recursive = true;
      source = ../wezterm;
    };

    ".config/ranger" = {
      recursive = true;
      source = ../ranger;
    };

    ".config/mako" = {
      recursive = true;
      source = ../mako;
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/markus/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables.EDITOR = "nvim";

  programs.home-manager.enable = true;

  programs.zsh =
    {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      history = {
        path = "$HOME/.cache/zsh/history";
      };
      shellAliases = {
        a = "ansible";
        p = "project.sh";
        g = "git";
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
      };
      initExtra = ''
        # Use vim keys in tab complete menu
        bindkey -M menuselect "h" vi-backward-char
        bindkey -M menuselect "k" vi-up-line-or-history
        bindkey -M menuselect "l" vi-forward-char
        bindkey -M menuselect "j" vi-down-line-or-history
        bindkey "^e" end-of-line
        bindkey -s "^o" ". ranger\n"

        export PATH="$PATH:$HOME/.local/share/coursier/bin"
        export PATH="$HOME/.local/bin:$PATH"
        export PATH="$HOME/.deno/bin:$PATH"
        export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
        export PATH="$HOME/apps:$PATH"
        export PATH="$HOME/.cargo/bin:$PATH"

        export GOPATH=$HOME/go
        export XDG_CONFIG_HOME=$HOME/.config

        export LANG=en_US.UTF-8
        export LANGUAGE=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
      '';
      initExtraBeforeCompInit = ''
        zstyle ":completion:*" menu select
        zmodload zsh/complist
      '';
    };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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
      add_newline = true;
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

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../eww;
  };
}
