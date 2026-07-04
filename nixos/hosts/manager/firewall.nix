{ ... }:

{
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [
      22 # SSH
      53 # DNS
      80 # HTTP
      443 # HTTPS
      2377 # Docker Swarm
      7946 # Docker Swarm
    ];
    allowedUDPPorts = [
      53 # DNS
      4789 # Docker Swarm
      7946 # Docker Swarm
      51820 # Wireguard
    ];
  };
}
