{
  nix.settings = {
    experimental-features = "nix-command flakes";

    trusted-users = [ "markus" ];

    builders-use-substitutes = true;

    substituters = [
      "https://cache.nixos.org"
    ];
  };
}
