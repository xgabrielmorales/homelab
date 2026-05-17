{ ... }:

{
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [
      22 # SSH
      2377 # Docker Swarm
      7946 # Docker Swarm
    ];
    allowedUDPPorts = [
      7946 # Docker Swarm
      4789 # Docker Swarm
    ];
  };
}
