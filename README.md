# Homelab

## Stack

Servers run [NixOS](https://nixos.org/). NixOS secrets managed with [sops-nix](https://github.com/Mic92/sops-nix).

| Component     | Technology                                                                                                                                                           |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OS            | [NixOS](https://nixos.org/)                                                                                                                                          |
| Orchestration | [Docker Swarm](https://docs.docker.com/engine/swarm/)                                                                                                                |
| Reverse Proxy | [Traefik](https://traefik.io/) ([auto-discovery](https://doc.traefik.io/traefik-hub/api-gateway/reference/install/providers/ref-provider-overview) via Swarm labels) |
| Secrets       | [Sops](https://github.com/getsops/sops) + [sops-nix](https://github.com/Mic92/sops-nix) + [age](https://github.com/FiloSottile/age)                                  |
| Certificates  | [Let's Encrypt](https://letsencrypt.org/) (ACME)                                                                                                                     |
| DNS Challenge | [Cloudflare](https://www.cloudflare.com/)                                                                                                                            |
| Monitoring    | [Prometheus](https://prometheus.io/) + [Grafana](https://grafana.com/)                                                                                               |

## Services

Some of the services I am currently self-hosting:

- [Degoog](https://github.com/degoog-org/degoog): Search engine aggregator.
- [Forgejo](https://forgejo.org/): Git server.
- [Invidious](https://invidious.io/): YouTube alternative frontend with no ads and no tracking.
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

```bash
$ sops exec-env .encrypted.env 'docker stack deploy --compose-file compose.yml <stack-name>'
```

## FAQ

<details>
<summary>What hardware do you use?</summary>

- Raspberry Pi 4 (4GB RAM)
- Mini PC (Intel N150, 16GB RAM)

_Last verified: January 11, 2026_

</details>
