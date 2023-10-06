{ config, pkgs, lib, ... }:

{
  imports = [ ./core.nix ];

  home.username = "markus";
  home.homeDirectory = "/Users/markus";

  home.packages = [
    pkgs.awscli2
  ];

  programs.git.extraConfig.credential.helper = "osxkeychain";
  programs.git.signing.signByDefault = lib.mkForce false;

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
