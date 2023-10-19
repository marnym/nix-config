{ config, pkgs, ... }:

{
  imports = [ ./core.nix ];

  home.username = "markusnyman";
  home.homeDirectory = "/Users/markusnyman";
  programs.git.extraConfig.credential.helper = "osxkeychain";

  programs.zsh.initExtra = ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

  programs.fish.shellInit = ''
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
  '';
}
