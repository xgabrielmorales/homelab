{ mainUser, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
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
  users.users.${mainUser}.extraGroups = [ "docker" ];
}
