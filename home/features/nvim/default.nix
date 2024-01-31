{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      nil
      nixpkgs-fmt
      lua-language-server
      gopls
      marksman
      texlab
      typescript
    ];
  };

  home.file.".config/nvim" = {
    recursive = true;
    source = ./config;
  };
}
