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
    # darwinLaunchOptions = [
    #   "--single-instance"
    # ];
  };
}
