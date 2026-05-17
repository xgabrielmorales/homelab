{ ... }:

{
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 15;
  boot.loader.systemd-boot.enable = true;
  boot.tmp.cleanOnBoot = true;
}
