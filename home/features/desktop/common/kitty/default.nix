{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    package = pkgs.unstable.kitty;
    font = {
      name = "BlexMono Nerd Font";
      size = 14;
    };
    shellIntegration.enableFishIntegration = true;
    theme = "Gruvbox Material Dark Hard";
    settings = {
      sync_to_monitor = "no";
      confirm_os_window_close = 0;
      cursor_shape = "beam";
    };
    # darwinLaunchOptions = [
    #   "--single-instance"
    # ];
  };
}
