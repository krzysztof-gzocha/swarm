![Build](https://github.com/krzysztof-gzocha/swarm/workflows/Build/badge.svg?branch=master)

# Swarm 
Docker swarm setup with basic applications.

# How to start?
- Install all required apps:
    - Docker
    - Docker compose
- `docker network create --driver=overlay traefik-public`
- Generate certificates (read [certs/README.md](https://github.com/krzysztof-gzocha/swarm/blob/master/certs/README.md) for that)
- Update all the variables in `.env` file
- Prepare users list for Traefik in `traefik.users.txt` and `traefik.media.txt` files
- Update all secrets in `config/secrets`
- Run `docker-compose -f traefik.yml -f pihole.yml -f monitoring.yml -f jellyfin.yml -f torrent.yml -f mosquitto.yml up` to get all services running
- PiHole admin panel password is "passw0rd", but that does not matter that much as Traefik will restrict access only by users you've mentioned in `traefik.users.txt` file
- Visit https://traefik.<SWARM_HOST>/dashboard/ or https://pihole.<SWARM_HOST>/
- Visit https://grafana.<SWARM_HOST> and import [this dashboard](https://grafana.com/grafana/dashboards/11467) to see stats from docker and [this dashboard](https://grafana.com/grafana/dashboards/11529) for network metrics and maybe import dashboard from assets/traefik_dashboard.json
- Configure your router to point to Traefik, which will then distribute the requests to all services based on port, HTTP host or other rules

# To do
- [x] Add [Pi-hole](https://hub.docker.com/r/pihole/pihole) as DNS and admin web panel
- [x] Add [Prometheus](https://hub.docker.com/r/prom/prometheus) and configure it to scrape metrics from Traefik and Docker containers
- [x] Add [Grafana](https://hub.docker.com/r/grafana/grafana) and configure it to read from Prometheus
- [x] Move Prometheus, Graphana and exporters into separate docker-compose file, so user can decide if he wants to run them
- [x] Add [DockerExporter](https://github.com/prometheus-net/docker_exporter), so we can present docker metrics for Prometheus
- [x] Add [BlackboxExporter](https://hub.docker.com/r/prom/blackbox-exporter), so we can send HTTP requests and check if network is working fine
- [x] Basic security configuration for each and every docker
- [x] Add [Authelia](https://github.com/authelia/authelia), configure Traefik to use it as authentication server. It's taking at least 1 GB RAM, so be careful
- [ ] Add [linuxserver/duckdns](https://hub.docker.com/r/linuxserver/duckdns) in separate docker-compose.yml
- [ ] Add [Shinobi](https://hub.docker.com/r/shinobisystems/shinobi) as video surveillance center 
- [x] Add [Mosquitto](https://hub.docker.com/_/eclipse-mosquitto) as MQTT broker
- [ ] Add [OwnCloud](https://hub.docker.com/_/owncloud) as file sharing center
- [x] Add [Jellyfin](https://hub.docker.com/r/jellyfin/jellyfin) as media server. Might take a lot of CPU when streaming and/or transcoding a video.
- [ ] Add [OpenFaaS](https://www.openfaas.com/)
- [x] Add Torrent related services: [Bazarr](https://github.com/morpheus65535/bazarr), [Sonarr](https://github.com/Sonarr/Sonarr), [Radarr](https://github.com/Radarr/Radarr) and [Jackett](https://github.com/Jackett/Jackett)
- [ ] Test on actual Docker swarm with multiple nodes
- [ ] Benchmark the hardware requirements with full setup using metrics from Prometheus
- [ ] Write README about how to deploy new versions of any service

Yea.. that's a lot of todos..

# Screens
![Docker exporter on Grafana](https://raw.githubusercontent.com/krzysztof-gzocha/swarm/master/assets/graphana.png?token=AAXUPP2UOMUW2JKSWGUUC627L5W2K)

# Common issues
### Port 53 is already taken
Use `sudo lsof -i :53` to confirm
That's how `/etc/systemd/resolved.conf` should look like.
```
[Resolve]
DNS=1.1.1.1
#FallbackDNS=
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#Cache=no
DNSStubListener=no
#ReadEtcHosts=yes
```
then `sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf`
and reboot your system.
