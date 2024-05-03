{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    escapeTime = 10;
    mouse = true;
    prefix = "C-a";
    resizeAmount = 10;
    terminal = "screen-256color";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      # Status line
      set -g status-right "%H:%M"
      set -g status-style "fg=#665c54"
      set -g status-left-style "fg=#928374"
      set -g status-bg default
      set -g status-position top
      set -g status-interval 1
      set -g status-left ""

      set -g base-index 1
      set -g pane-base-index 1

      # If running inside tmux ($TMUX is set), then change the status line to red
      %if #{TMUX}
      set -g status-bg red
      %endif

      # neovim specifics
      set-option -g focus-events on

      # Enable RGB colour if running in xterm(1)
      set -a terminal-features '*:RGB'

      # No bells at all
      set -g bell-action none

      unbind -n MouseDrag1Pane
      unbind -T copy-mode MouseDrag1Pane
      unbind -T copy-mode-vi MouseDragEnd1Pane
      bind-key -T copy-mode-vi y send-keys -X copy-selection

      bind t split-window -f -l 15 -c "#{pane_current_path}"
      bind T split-window -h -f -p 35 -c "#{pane_current_path}"

      bind space copy-mode
    '';
  };
}
