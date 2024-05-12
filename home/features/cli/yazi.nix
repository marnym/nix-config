{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_reverse = false;
        sort_dir_first = true;
        show_symlink = true;
      };
    };
  };

  programs.fish.interactiveShellInit = /*fish */ ''
    function yy
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      TERM=foot yazi $argv --cwd-file="$tmp"
      if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
      end
      rm -f -- "$tmp"
    end
  '';
}
