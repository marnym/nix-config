{ pkgs, lib, config, ... }: {
  users = {
    mutableUsers = false;
    users = {
      markus = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.fish;
        hashedPassword = lib.mkDefault "$y$j9T$GsfORnC5W3lX4vd5ZNnl4.$br9rkMZi7jk9VL69scPzpGLpy2SkOjwvBjRF4QlWfj8";
        packages = [ pkgs.home-manager ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYrteSUBgXlSPuZagjKFJQcfWhS10wQrJo3pVZtlm1P markus"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPrndQoxNh1dr9O9yuBG6NiQvOgWCcTsk8Wz02N2mhoN markus"
        ];
      };
    };
  };

  home-manager.users.markus = import ../../../home/${config.networking.hostName}.nix;
}
