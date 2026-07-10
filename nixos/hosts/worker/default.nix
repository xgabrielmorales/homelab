{ ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix

    # Core system
    ./firewall.nix
    ../../modules/core/sops.nix
    ../../modules/core/boot.nix
    ../../modules/core/locale.nix
    ../../modules/core/networking.nix
    ../../modules/core/nix.nix
    ../../modules/core/security.nix

    # Hardware support
    ../../modules/hardware/audio.nix
    ../../modules/hardware/bluetooth.nix

    # System settings
    ../../modules/system/user.nix
    ../../modules/system/packages.nix

    # Services
    ../../modules/services/docker.nix
    ../../modules/services/ssh.nix
    ./k3s.nix
  ];

  system.stateVersion = "25.11";
}
