[working-directory: 'nixos']
update:
  nix flake update

[working-directory: 'nixos']
deploy-manager host:
  nh os switch . -H xgm-homelab-manager --target-host {{host}}

[working-directory: 'nixos']
deploy-worker host:
  nh os switch . -H xgm-homelab-worker --target-host {{host}}
