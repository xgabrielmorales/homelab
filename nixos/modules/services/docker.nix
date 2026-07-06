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
        "10.10.10.2" # My own dns server
        "1.1.1.1" # Cloudflare
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
