{ pkgs, lib, ... }:

{
  programs = {
    nano.enable = false;
  };

  documentation.nixos.enable = false;

  environment = {
    defaultPackages = lib.mkForce [ ];
    systemPackages = with pkgs; [
      git
      htop
      vim
      just
    ];
  };
}
