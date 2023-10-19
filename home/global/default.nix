{ pkgs, ... }: {

  imports = [
    ../../modules/nixos/nix-settings.nix

    ../features/cli
    ../features/nvim
  ];

  nix.package = pkgs.nix;

  home.packages = with pkgs; [
    nix-output-monitor
    nixfmt
  ];

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
