{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.intel-undervolt;
in
{
  options.services.intel-undervolt.enable = mkEnableOption "intel-undervolt";

  config = mkIf cfg.enable {
    systemd.services.intel-undervolt = {
      description = "Intel Undervolt Service";
      after = [
        "multi-user.target"
        "suspend.target"
        "hibernate.target"
        "hybrid-sleep.target"
      ];
      wantedBy = [
        "multi-user.target"
        "suspend.target"
        "hibernate.target"
        "hybrid-sleep.target"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.intel-undervolt}/bin/intel-undervolt apply";
      };
    };
  };
}
