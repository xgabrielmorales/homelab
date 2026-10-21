[working-directory: 'nixos']
update:
  nix flake update

[working-directory: 'nixos']
deploy-manager host:
  nixos-rebuild switch --flake .#xgm-homelab-manager --target-host {{host}} --sudo --ask-sudo-password

[working-directory: 'nixos']
deploy-worker host:
  nixos-rebuild switch --flake .#xgm-homelab-worker --target-host {{host}} --sudo --ask-sudo-password
