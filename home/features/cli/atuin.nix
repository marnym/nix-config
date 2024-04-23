{ pkgs-unstable, ... }: {
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs-unstable.atuin;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      auto_sync = false;
      search_mode = "fuzzy";
      style = "compact";
    };
  };
}
