{ pkgs, ... }: {

  imports = [
    ../features/cli
    ../features/nvim
  ];

  home.packages = with pkgs; [
    nix-output-monitor
    nixfmt-rfc-style
  ];

  home.file.".local/bin" = {
    source = ../../scripts;
    recursive = true;
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
