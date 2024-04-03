{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = lib.mkDefault pkgs.unstable.neovim-unwrapped;
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
    ];
  };

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
