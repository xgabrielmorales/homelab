{ pkgs, lib, ... }:

{
  programs = {
    nano.enable = false;
  };

  documentation.nixos.enable = false;

  environment = {
    defaultPackages = lib.mkForce [ ];
    systemPackages = with pkgs; [
      age
      git
      htop
      just
      sops
      vim
    ];
  };
}
