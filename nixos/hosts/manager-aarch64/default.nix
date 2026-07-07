{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
    ../manager/firewall.nix
    ../../modules/core/sops.nix
    ../../modules/core/locale.nix
    ../../modules/core/networking.nix
    ../../modules/core/nix.nix
    ../../modules/core/security.nix
    ../../modules/hardware/audio.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/system/user.nix
    ../../modules/system/packages.nix
    ../../modules/services/docker.nix
    ../../modules/services/ssh.nix
  ];

  nixpkgs.hostPlatform = "aarch64-linux";
  system.stateVersion = "25.11";
}
