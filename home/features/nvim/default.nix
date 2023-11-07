{ pkgs, ... }:

{
  programs.neovim = with pkgs.unstable; {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = neovim-unwrapped;
  };

  home.packages = with pkgs.unstable; [
    lua-language-server
    nixpkgs-fmt
    marksman
    gopls
  ];

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
