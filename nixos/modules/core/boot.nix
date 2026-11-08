_:

{
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 15;
      systemd-boot.enable = true;
    };
    tmp.cleanOnBoot = true;
  };
}
