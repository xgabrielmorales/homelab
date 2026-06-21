{ mainUser, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      flags = [
        "--all"
        "--volumes"
      ];
    };
    daemon.settings = {
      dns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };

  systemd.services.docker = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    startLimitIntervalSec = 0;
    serviceConfig.RestartSec = "5s";
  };

  users.users.${mainUser}.extraGroups = [ "docker" ];
}
