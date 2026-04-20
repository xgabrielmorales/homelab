# Homelab

## Stack

| Component     | Technology                                                                                                                                                           |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Orchestration | [Docker Swarm](https://docs.docker.com/engine/swarm/)                                                                                                                |
| Reverse Proxy | [Traefik](https://traefik.io/) ([auto-discovery](https://doc.traefik.io/traefik-hub/api-gateway/reference/install/providers/ref-provider-overview) via Swarm labels) |
| Secrets       | [SOPS](https://github.com/getsops/sops) + [AGE](https://github.com/FiloSottile/age)                                                                                  |
| Certificates  | [Let's Encrypt](https://letsencrypt.org/) (ACME)                                                                                                                     |
| DNS Challenge | [Cloudflare](https://www.cloudflare.com/)                                                                                                                            |
| Monitoring    | [Prometheus](https://prometheus.io/) + [Grafana](https://grafana.com/)                                                                                               |

## Services

Some of the services I am currently self-hosting:

- [Pi-hole](https://pi-hole.net/): Network-wide ad blocker.
- [WireGuard](https://www.wireguard.com/): VPN to access my home network from anywhere.
- [Invidious](https://invidious.io/): YouTube alternative front-end with no ads, no tracking.
- [Redlib](https://github.com/redlib-org/redlib): Reddit alternative front-end with no ads, no tracking.

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

*Last verified: January 11, 2026*

</details>

<details>
<summary>Why isn't WireGuard included in the Swarm cluster?</summary>

Docker Swarm creates an overlay network that adds a layer of network abstraction. WireGuard requires direct access to host network interfaces, which becomes complicated with Swarm's encapsulation. It's simpler to run WireGuard with docker-compose on a specific node.

*Last verified: January 11, 2026*

</details>
