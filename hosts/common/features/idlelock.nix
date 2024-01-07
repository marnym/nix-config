{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ swayidle swaylock ];

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
