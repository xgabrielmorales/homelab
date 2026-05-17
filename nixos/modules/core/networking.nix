{ mainUser, ... }:

{
  networking = {
    hostName = mainUser;
    networkmanager.enable = false;
    useDHCP = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
  services.resolved = {
    enable = true;
    settings.Resolve.FallbackDNS = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
