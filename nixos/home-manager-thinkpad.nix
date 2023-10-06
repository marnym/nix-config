{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.markus = {
    home.stateVersion = "23.05";
    imports = [
      /home/markus/.dotfiles/nix/thinkpad.nix
    ];
  };
}
