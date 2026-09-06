{ ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-mode=0644"
      "--kubelet-arg=image-gc-high-threshold=80"
      "--kubelet-arg=image-gc-low-threshold=70"
    ];
  };
}
