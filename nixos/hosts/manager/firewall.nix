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
      6443 # k3s API (kubectl)
      10250 # k3s kubelet
      6881 # qBittorrent peers (hostPort)
      2222 # forgejo git SSH (hostPort)
    ];
    allowedUDPPorts = [
      53 # DNS
      51820 # Wireguard
      8472 # k3s flannel VXLAN
      6881 # qBittorrent peers (hostPort)
    ];
  };
}
