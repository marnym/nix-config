{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./global

    ./features/desktop/common
    ./features/desktop/common/darwin

    ./features/productivity/glow.nix
    ./features/productivity/documents/typst.nix
  ];

  nix.package = pkgs.nix;

  nix.settings = {
    experimental-features = "nix-command flakes";

    trusted-users = [ "markus" ];

    builders-use-substitutes = true;

    substituters = [ "https://cache.nixos.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];

    extra-substituters = [
      "https://hydra.nixos.org"
      "https://nix-community.cachix.org"
      "https://ghostty.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

  home.username = "markus";
  home.homeDirectory = "/Users/markus";

  home.packages = with pkgs; [
    awscli2
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

  home.file."/Users/markus/Library/Application Support/typst/packages/local/homework-template/0.1.0".source = inputs.homework-template;

}
