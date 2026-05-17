{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
    }:
    {
      nixosConfigurations.xgm-homelab-manager = nixpkgs.lib.nixosSystem {
        specialArgs = {
          mainUser = "xgm-hm";
        };
        modules = [
          ./hosts/manager/default.nix
          sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.xgm-homelab-worker = nixpkgs.lib.nixosSystem {
        specialArgs = {
          mainUser = "xgm-hw";
        };
        modules = [
          ./hosts/worker/default.nix
          sops-nix.nixosModules.sops
        ];
      };
    };
}
