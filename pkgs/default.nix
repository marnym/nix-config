pkgs: {
  intel-undervolt = pkgs.callPackage ./intel-undervolt.nix { };
  hyprshot = pkgs.callPackage ./hyprshot.nix { };
}
