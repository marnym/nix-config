{ pkgs, pkgs-unstable, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs-unstable.neovim-unwrapped;
    extraPackages = with pkgs; [
      fswatch

      nil
      nixpkgs-fmt
      lua-language-server
      gopls
      marksman
      texlab
      ltex-ls
      nodePackages.bash-language-server
      typescript

      ansible-language-server
      yaml-language-server
    ];
  };

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
