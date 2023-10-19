{ pkgs, ... }:

{
  imports = [
    ../nix-settings.nix
    ../syncthing.nix
  ];

  programs.fish.enable = true;

  virtualisation.docker.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fi";
  };

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "*";
      };
      markus = {
        group = "nixos";
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.fish;
        hashedPassword = "$y$j9T$GsfORnC5W3lX4vd5ZNnl4.$br9rkMZi7jk9VL69scPzpGLpy2SkOjwvBjRF4QlWfj8";
      };
    };

    groups = {
      nixos = { };
    };
  };

  environment.systemPackages = with pkgs; [
    git
    pkgs.unstable.neovim
    wget
    curl
  ];

  environment.variables.EDITOR = "nvim";

  system.stateVersion = "23.05";
}
