{ config, pkgs, lib, ... }:

{
  nix = {
    package = lib.mkForce pkgs.nix;
    settings.experimental-features = lib.mkForce [ "nix-command" "flakes" ];
    settings.max-jobs = lib.mkForce "auto";
  };

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    gcc
    rustup
    go
    deno
    nodejs_20
    rage
    tldr
    ranger
    grc
    jq
    ripgrep
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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
      source = ./nvim;
    };


    ".config/wezterm" = {
      recursive = true;
      source = ./wezterm;
    };

    ".config/ranger" = {
      recursive = true;
      source = ./ranger;
    };

    ".config/fish/themes" = {
      recursive = true;
      source = ./fish/themes;
    };

    ".ideavimrc" = {
      source = ./jetbrains/.ideavimrc;
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

  programs.fish = {
    enable = true;
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
    shellAliases = {
      a = "ansible";
      p = "project.sh";
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      pandoc = "pandoc --pdf-engine=xelatex";
      cat = "bat";
    };
    shellInit = ''
      set -U fish_greeting "🐟"
      fish_add_path "$HOME/.local/bin"
      fish_add_path "$HOME/.nix-profile/bin"
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh =
    {
      enable = false;
      enableAutosuggestions = true;
      enableCompletion = true;
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
        pandoc = "pandoc --pdf-engine=xelatex";
      };
      initExtra = ''
        set -o emacs

        # Use vim keys in tab complete menu
        bindkey -M menuselect "h" vi-backward-char
        bindkey -M menuselect "k" vi-up-line-or-history
        bindkey -M menuselect "l" vi-forward-char
        bindkey -M menuselect "j" vi-down-line-or-history
        bindkey "^e" end-of-line
        bindkey -s "^o" ". ranger\n"

        export PATH="$PATH:$HOME/.local/share/coursier/bin"
        export PATH="$HOME/.local/bin:$PATH"
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
    enableFishIntegration = true;
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

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    escapeTime = 10;
    mouse = true;
    prefix = "C-Space";
    resizeAmount = 10;
    terminal = "screen-256color";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      # Some tweaks to the status line
      set-option -g status-position bottom
      set -g status-right "%H:%M"
      set -g status-left-length 20
      set -g window-status-separator ""
      set -g status-justify centre

      # If running inside tmux ($TMUX is set), then change the status line to red
      %if #{TMUX}
      set -g status-bg red
      %endif

      # neovim specifics
      set-option -g focus-events on

      # Enable RGB colour if running in xterm(1)
      set-option -sa terminal-overrides ",xterm*:Tc"

      # No bells at all
      set -g bell-action none

      # Keep windows around after they exit
      set -g remain-on-exit on

      unbind -n MouseDrag1Pane
      unbind -T copy-mode MouseDrag1Pane
      unbind -T copy-mode-vi MouseDragEnd1Pane
      bind-key -T copy-mode-vi y send-keys -X copy-selection

      bind t split-window -f -l 15 -c "#{pane_current_path}"
      bind T split-window -h -f -p 35 -c "#{pane_current_path}"
    '';
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
  };
}
