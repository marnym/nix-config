{ pkgs-unstable, ... }: {
  programs.kitty = {
    enable = true;
    package = pkgs-unstable.kitty;
    font = {
      name = "Maple Mono NF";
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
