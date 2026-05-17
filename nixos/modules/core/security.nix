{ ... }:

{
  security.polkit.enable = true;
  programs.ssh.startAgent = true;

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h";
    };
    jails.sshd.settings = {
      enabled = true;
      port = "ssh";
      filter = "sshd";
      maxretry = 3;
    };
  };
}
