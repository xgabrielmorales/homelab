{ ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
