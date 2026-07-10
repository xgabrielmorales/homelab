{ config, ... }:

{
  sops.secrets.k3s_token = { };
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://10.10.10.3:6443";
    tokenFile = config.sops.secrets.k3s_token.path;
    extraFlags = [ "--node-taint=worker=true:NoSchedule" ];
  };
}
