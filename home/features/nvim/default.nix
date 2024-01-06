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
    # LSP
    nil
    nixpkgs-fmt
    lua-language-server
    gopls
    marksman
    texlab
    typescript

    # TreeSitter
    vimPlugins.nvim-treesitter-parsers.bash
    vimPlugins.nvim-treesitter-parsers.bibtex
    vimPlugins.nvim-treesitter-parsers.c
    vimPlugins.nvim-treesitter-parsers.comment
    vimPlugins.nvim-treesitter-parsers.cmake
    vimPlugins.nvim-treesitter-parsers.cpp
    vimPlugins.nvim-treesitter-parsers.css
    vimPlugins.nvim-treesitter-parsers.dockerfile
    vimPlugins.nvim-treesitter-parsers.go
    vimPlugins.nvim-treesitter-parsers.hcl
    vimPlugins.nvim-treesitter-parsers.html
    vimPlugins.nvim-treesitter-parsers.java
    vimPlugins.nvim-treesitter-parsers.javascript
    vimPlugins.nvim-treesitter-parsers.json
    vimPlugins.nvim-treesitter-parsers.kotlin
    vimPlugins.nvim-treesitter-parsers.latex
    vimPlugins.nvim-treesitter-parsers.lua
    vimPlugins.nvim-treesitter-parsers.nix
    vimPlugins.nvim-treesitter-parsers.python
    vimPlugins.nvim-treesitter-parsers.rust
    vimPlugins.nvim-treesitter-parsers.scala
    vimPlugins.nvim-treesitter-parsers.scss
    vimPlugins.nvim-treesitter-parsers.toml
    vimPlugins.nvim-treesitter-parsers.tsx
    vimPlugins.nvim-treesitter-parsers.typescript
    vimPlugins.nvim-treesitter-parsers.vimdoc
    vimPlugins.nvim-treesitter-parsers.vue
    vimPlugins.nvim-treesitter-parsers.yaml
  ];

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
