{ ... }:

{
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [
      22 # SSH
      10250 # k3s kubelet
    ];
    allowedUDPPorts = [
      8472 # k3s flannel VXLAN
    ];
  };
}
