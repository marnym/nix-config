{ pkgs, ... }: {
  home.file = {
    ".config/fish/themes" = {
      recursive = true;
      source = ./themes;
    };
  };

  programs.fish = {
    enable = true;
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
    shellAliases = {
      a = "ansible";
      p = "project.sh";

      lg = "lazygit";
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gp = "git pull";
      gP = "git push";
      gsw = "g switch";
      pandoc = "pandoc --pdf-engine=xelatex";
      cat = "bat";
    };
    shellInit = ''
      set -U fish_greeting "🐟"
      fish_add_path "$HOME/.local/bin"
    '';
  };
}
