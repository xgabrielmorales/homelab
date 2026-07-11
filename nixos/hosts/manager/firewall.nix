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
      6443 # k3s API (kubectl)
      8000 # k3s Traefik catch-all entrypoint
      10250 # k3s kubelet
      6881 # qBittorrent peers (hostPort)
      2222 # forgejo git SSH (hostPort)
    ];
    allowedUDPPorts = [
      53 # DNS
      4789 # Docker Swarm
      7946 # Docker Swarm
      51820 # Wireguard
      8472 # k3s flannel VXLAN
      6881 # qBittorrent peers (hostPort)
    ];
  };
}
