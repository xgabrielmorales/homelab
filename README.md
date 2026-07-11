# Homelab

## Stack

Servers run [NixOS](https://nixos.org/). NixOS secrets managed with [sops-nix](https://github.com/Mic92/sops-nix).

| Component          | Technology                                                                                                                                                     |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OS                 | [NixOS](https://nixos.org/)                                                                                                                                    |
| Orchestration      | [Kubernetes](https://kubernetes.io/) ([k3s](https://k3s.io/))                                                                                                  |
| Reverse Proxy      | [Traefik](https://traefik.io/) (bundled with k3s, auto-discovery via `Ingress`)                                                                                |
| Secrets            | [Sops](https://github.com/getsops/sops) + [sops-nix](https://github.com/Mic92/sops-nix) + [age](https://github.com/FiloSottile/age)                            |
| Certificates       | [Let's Encrypt](https://letsencrypt.org/) (ACME)                                                                                                               |
| DNS Challenge      | [Cloudflare](https://www.cloudflare.com/)                                                                                                                      |
| Observability      | [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts) + [Loki](https://grafana.com/oss/loki/) + [Alloy](https://grafana.com/oss/alloy/) |
| GitOps             | [Flux](https://fluxcd.io/)                                                                                                                                     |
| Dependency Updates | [Renovate](https://docs.renovatebot.com/)                                                                                                                      |

## Services

Some of the services I am currently self-hosting:

- [Degoog](https://github.com/degoog-org/degoog): Search engine aggregator.
- [Forgejo](https://forgejo.org/): Git server.
- [Invidious](https://invidious.io/): YouTube alternative frontend with no ads and no tracking.
- [Jellyfin](https://jellyfin.org/): Media server for open source movies and TV shows.
- [Redlib](https://github.com/redlib-org/redlib): Reddit alternative frontend with no ads and no tracking.
- [Technitium](https://technitium.com/dns/): Recursive DNS server that also blocks ads.
- [WireGuard](https://www.wireguard.com/): VPN to access my home network.

## Deploy

The cluster is [k3s](https://k3s.io/), enabled declaratively using NixOS modules under `nixos/`. Everything under `k8s/`
is reconciled by [Flux](https://fluxcd.io/), which watches this repo's `trunk` branch. Flux decrypts SOPS secrets using
the age key.

### Renovate

[Renovate](https://docs.renovatebot.com/) scans the Kubernetes manifests and Flux `HelmRelease`s under
`k8s/` for outdated images and chart versions, and opens pull requests in Forgejo automatically. It runs
on demand.

```bash
cd renovate
sops exec-env .encrypted.env 'docker compose run --rm renovate'
```

## FAQ

<details>
<summary>What hardware do you use?</summary>

- Raspberry Pi 4 (4GB RAM)
- Mini PC (Intel N150, 16GB RAM)

**Last verified: January 11, 2026**
</details>
