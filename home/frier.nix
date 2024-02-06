{ config, pkgs, lib, ... }:

{
  imports = [
    ./global

    ./features/desktop/common
    ./features/desktop/common/darwin

    ./features/productivity
  ];

  nix.package = pkgs.nix;

  nix.settings = {
    experimental-features = "nix-command flakes";

    trusted-users = [ "markusnyman" ];

    builders-use-substitutes = true;

    substituters = [ "https://cache.nixos.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];

    extra-substituters = [
      "https://hydra.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://ghostty.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

  home.username = "markusnyman";
  home.homeDirectory = "/Users/markusnyman";

  programs.git.extraConfig.credential.helper = "osxkeychain";
  programs.git.signing.signByDefault = lib.mkForce
    false;

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
