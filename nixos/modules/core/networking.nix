{ mainUser, ... }:

{
  networking = {
    hostName = mainUser;
    networkmanager.enable = false;
    useDHCP = true;
    dhcpcd = {
      extraConfig = "noipv4ll";
      wait = "ipv4";
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    hosts."10.10.10.3" = [ "git.xgabrielmorales.com" ];
  };
  services.resolved = {
    enable = true;
    settings.Resolve.FallbackDNS = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
