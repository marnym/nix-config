{ config, pkgs, ... }:

{
  imports = [ ./core.nix ];

  home.username = "markusnyman";
  home.homeDirectory = "/Users/markusnyman";
  programs.git.extraConfig.credential.helper = "osxkeychain";
}
