{ pkgs, ... }:

{
  imports = [
    ../../../modules/nix-settings.nix
    ./neovim
  ];

  nix.package = pkgs.nix;

  home.packages = with pkgs; [
    neofetch
    ranger

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
  ];

  home.file = {
    ".config/ranger" = {
      recursive = true;
      source = ./ranger;
    };

    ".config/fish/themes" = {
      recursive = true;
      source = ./fish/themes;
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
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
