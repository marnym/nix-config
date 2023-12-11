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
    extraConfig = ''
      confirm_os_window_close 0
    '';
    # darwinLaunchOptions = [
    #   "--single-instance"
    # ];
  };
}
