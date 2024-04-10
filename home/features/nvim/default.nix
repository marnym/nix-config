{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = lib.mkDefault pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      fswatch

      nil
      nixpkgs-fmt
      lua-language-server
      gopls
      marksman
      texlab
      ltex-ls
      typescript
      yaml-language-server
    ];
  };

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
