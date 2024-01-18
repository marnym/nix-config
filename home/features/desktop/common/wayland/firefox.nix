{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    profiles.default.id = 0;
    profiles.default.isDefault = true;
    profiles.default.settings = {
      # Disable pocket
      "extensions.pocket.enable" = false;
      # Disable firefox reacting to media keys
      "media.hardwaremediakeys.enabled" = false;
    };
  };
}
