{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-nightly;
  };

  home.packages = with pkgs.unstable; [
    # LSP
    nil
    nixpkgs-fmt
    lua-language-server
    gopls
    marksman
    texlab
    typescript
    yaml-language-server

    # TreeSitter
    vimPlugins.nvim-treesitter.withAllGrammars
  ];

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
