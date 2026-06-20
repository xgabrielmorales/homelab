# Homelab

## Stack

Servers run [NixOS](https://nixos.org/). NixOS secrets managed with [sops-nix](https://github.com/Mic92/sops-nix).

| Component          | Technology                                                                                                                                                           |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OS                 | [NixOS](https://nixos.org/)                                                                                                                                          |
| Orchestration      | [Docker Swarm](https://docs.docker.com/engine/swarm/)                                                                                                                |
| Reverse Proxy      | [Traefik](https://traefik.io/) ([auto-discovery](https://doc.traefik.io/traefik-hub/api-gateway/reference/install/providers/ref-provider-overview) via Swarm labels) |
| Secrets            | [Sops](https://github.com/getsops/sops) + [sops-nix](https://github.com/Mic92/sops-nix) + [age](https://github.com/FiloSottile/age)                                  |
| Certificates       | [Let's Encrypt](https://letsencrypt.org/) (ACME)                                                                                                                     |
| DNS Challenge      | [Cloudflare](https://www.cloudflare.com/)                                                                                                                            |
| Observability      | [Prometheus](https://prometheus.io/) + [Grafana](https://grafana.com/) + [Loki](https://grafana.com/oss/loki/) + [Alloy](https://grafana.com/oss/alloy/)             |
| GitOps             | [doco-cd](https://doco.cd/)                                                                                                                                          |
| Dependency Updates | [Renovate](https://docs.renovatebot.com/)                                                                                                                            |

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

Create the overlay network first:

```bash
docker network create --driver overlay --scope swarm --attachable reverse-proxy-swarm
```

The AGE key file (`keys.txt`) must be in the repository root. From a service directory:

```bash
$ SOPS_AGE_KEY_FILE="$(git rev-parse --show-toplevel)/keys.txt"
$ SOPS_CONFIG="$(git rev-parse --show-toplevel)/.sops.yaml"
```

### doco-cd

[doco-cd](https://doco.cd/) manages all subsequent deployments automatically. It requires the AGE secret key as a Swarm secret.

Create the secret once on the manager node:

```bash
$ cat keys.txt | docker secret create sops_age_key -
```

Then deploy doco-cd:

```bash
$ docker stack deploy --compose-file gitops/compose.yml doco-cd
```

From this point, pushing to `trunk` triggers automatic deployment of all stacks within 60 seconds.

### Renovate

[Renovate](https://docs.renovatebot.com/) scans Docker Compose files under `swarm/` for outdated images and opens pull requests in Forgejo automatically. It runs on demand.

```bash
$ cd renovate
$ sops exec-env .encrypted.env 'docker compose run --rm renovate'
```

## FAQ

<details>
<summary>What hardware do you use?</summary>

- Raspberry Pi 4 (4GB RAM)
- Mini PC (Intel N150, 16GB RAM)

_Last verified: January 11, 2026_

</details>
