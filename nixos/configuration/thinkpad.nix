{ pkgs-unstable, inputs, outputs, ... }:

{
  imports = [
    ../configuration.nix
    ../hardware-configuration/thinkpad.nix
    ../../modules/nixos/intel-undervolt.nix
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = pkgs-unstable;
      hyprland-flake = inputs.hyprland.packages.${pkgs.system}.hyprland;
      intel-undervolt = outputs.packages.x86_64-linux.intel-undervolt;
    };
  };

  environment.systemPackages = [ outputs.packages.x86_64-linux.intel-undervolt ];

  services.intel-undervolt.enable = true;

  networking.hostName = "thinkpad";
}
