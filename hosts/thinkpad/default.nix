{ inputs, pkgs, intel-undervolt, ... }:

{
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t490

    ./hardware-configuration.nix

    ../common/global
    ../common/features/bluetooth.nix
    ../common/features/brightness.nix
    ../common/features/docker.nix
    ../common/features/hyprland.nix
    ../common/features/mullvad.nix
    ../common/features/syncthing.nix
  ];

  networking.hostName = "thinkpad";

  environment.systemPackages = with pkgs; [
    acpi
    powertop
    intel-gpu-tools
    intel-undervolt
    bluez
  ];

  services.undervolt = {
    enable = true;
    useTimer = true;
    analogioOffset = 0;
    coreOffset = -120;
    uncoreOffset = -50;
    gpuOffset = -75;
    p1.limit = 60;
    p1.window = 30;
    p2.limit = 30;
    p2.window = 100000;
    temp = 80;
  };

  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
      USB_AUTOSUSPEND = 0;
      PCIE_ASPM_ON_BAT = "powersupersave";
      INTEL_GPU_MIN_FREQ_ON_AC = 500;
      INTEL_GPU_MIN_FREQ_ON_BAT = 500;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };
}
