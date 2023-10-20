{ pkgs, ... }: {

  imports = [
    ../features/cli
    ../features/nvim
  ];

  home.packages = with pkgs; [
    nix-output-monitor
    nixfmt
  ];

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
