# Flux bootstrap

## Steps

1. **Enter the Flux CLI**

   ```bash
   nix shell nixpkgs#fluxcd
   flux check --pre
   ```

2. **Install the controllers**

   ```bash
   kubectl apply -f k8s/flux-system/gotk-components.yaml
   kubectl -n flux-system wait --for=condition=Available deployment --all --timeout=300s
   ```

3. **Seed the age key**

   ```bash
   kubectl -n flux-system create secret generic sops-age --from-file=age.agekey=keys.txt
   ```

4. **Start self-management**

   ```bash
   kubectl apply -f k8s/flux-system/gotk-sync.yaml
   ```

5. **Verify:**

   ```bash
   flux get kustomizations   # flux-system → Ready: True
   flux get sources git      # flux-system → stored artifact
   ```

## Regenerating the manifests (only if `flux-system/` is lost)

```bash
flux install --export > k8s/flux-system/gotk-components.yaml

flux create source git flux-system \
  --url=https://git.xgabrielmorales.com/xgabrielmorales/homelab.git \
  --branch=trunk --interval=1m \
  --export > k8s/flux-system/gotk-sync.yaml

flux create kustomization flux-system \
  --source=GitRepository/flux-system \
  --path=./k8s --prune=true --interval=1m \
  --decryption-provider=sops --decryption-secret=sops-age \
  --export >> k8s/flux-system/gotk-sync.yaml
```

Then commit, push, and run the steps above.
