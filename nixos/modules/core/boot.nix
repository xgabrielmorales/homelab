_:

{
  boot = {
    consoleLogLevel = 0;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 15;
      systemd-boot.enable = true;
    };
    tmp.cleanOnBoot = true;
  };
}
