{ config, pkgs, inputs, outputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    users.markus = import ./${config.networking.hostName}.nix;
  };
}
