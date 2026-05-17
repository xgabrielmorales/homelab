{ mainUser, ... }:

{
  sops.secrets."ssh/authorized_keys/xgm" = {
    mode = "0444";
    path = "/etc/ssh/authorized_keys.d/${mainUser}";
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ mainUser ];
    };
  };
}
