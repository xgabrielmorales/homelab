# Networking notes

In Swarm the container has two interfaces:

- `eth0` — overlay network (`reverse-proxy-swarm`)
- `eth1` — `docker_gwbridge`, holds the default route (real internet egress)

wg-easy auto-detects the egress interface and resolves the `{{device}}` template to `eth0`, which is the **wrong** NIC. VPN client traffic leaves via `eth1` without NAT, so replies never return and clients have no internet despite a successful handshake.

Fix: override the interface in the PostUp/PostDown hooks with the `eth+` wildcard (matches `eth0`, `eth1`, ... — survives NIC reordering across redeploys). The published UDP port uses `mode: host` to bypass the Swarm ingress mesh, which would otherwise SNAT the UDP packets and break WireGuard's real client IP.

## PostUp

```sh
iptables -t nat -A POSTROUTING -s {{ipv4Cidr}} -o eth+ -j MASQUERADE; iptables -A INPUT -p udp -m udp --dport {{port}} -j ACCEPT; iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -s {{ipv6Cidr}} -o eth+ -j MASQUERADE; ip6tables -A INPUT -p udp -m udp --dport {{port}} -j ACCEPT; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -A FORWARD -o wg0 -j ACCEPT;
```

## PostDown

```sh
iptables -t nat -D POSTROUTING -s {{ipv4Cidr}} -o eth+ -j MASQUERADE; iptables -D INPUT -p udp -m udp --dport {{port}} -j ACCEPT; iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -s {{ipv6Cidr}} -o eth+ -j MASQUERADE; ip6tables -D INPUT -p udp -m udp --dport {{port}} -j ACCEPT; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -D FORWARD -o wg0 -j ACCEPT;
```
