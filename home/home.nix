{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../modules/nix.nix
  ];

  nix.package = pkgs.nix;

  home.packages = with pkgs; [
    neofetch
    nnn

    #archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    jq
    yq-go
    exa
    fzf

    # networking tools
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    # misc
    grc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    age
    tldr

    # nix
    nix-output-monitor
    nixfmt

    # productivity
    hugo
    glow

    btop
    iotop
    iftop

    # system call monitoring
    strace
    ltrace
    lsof

    # system tools
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils

    # development
    gcc
    gnumake
    rustup
    go
    deno
    nodejs_20
    temurin-bin-17
    sqlite

    # neovim
    pkgs-unstable.neovim-unwrapped
    pkgs-unstable.nixpkgs-fmt

    # document rendering
    pandoc
    texlive.combined.scheme-full
    librsvg

    # font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = ../nvim;
    };

    ".config/wezterm" = {
      recursive = true;
      source = ../wezterm;
    };

    ".config/ranger" = {
      recursive = true;
      source = ../ranger;
    };

    ".config/fish/themes" = {
      recursive = true;
      source = ../fish/themes;
    };

    ".ideavimrc" = {
      source = ../jetbrains/.ideavimrc;
    };
  };

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
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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
    package = pkgs-unstable.neovim-unwrapped;
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

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
