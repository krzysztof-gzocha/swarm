# Swarm
Docker swarm setup with basic applications.

# How to start?
- Install all required apps:
 - Docker
 - Docker compose
- Generate certificates (read certs/README.md for that)
- Prepare users list in `users` file
- Run `docker-compose up`
- PiHole admin panel password is "admin", but that does not matter that much as Traefik will restrict access only by users you've mentioned in `users` file
- Visit https://traefik.localhost/dashboard/ or https://pihole.localhost/
- Configure your router to point to Traefik, which will then distribute the request 
load to other services based on Host or other rules

# To do
- [x] Add Pi Hole as DNS and admin web panel
- [ ] Add DockerExporter/Swarmpit/anything that can present docker swarm metrics for Prometheus
- [ ] Add Prometheus and configure it to scrape metrics from Traefik and Docker containers
- [ ] Add Grafana and configure it to read from Prometheus
- [ ] Move Prometheus, Graphana and exporters into separate docker-compose file, so user can decide if he wants to run them
- [ ] Basic security configuration for each and every docker
- [ ] Add [Authelia](https://github.com/authelia/authelia), configure Traefik to use it as authentication server and make sure it will run on every node in HA mode
- [ ] Add NAS/MediaServer container in separate docker-compose.yml
- [ ] Add [linuxserver/duckdns](https://hub.docker.com/r/linuxserver/duckdns) in separate docker-compose.yml
- [ ] Add [ZoneMinder](https://github.com/ZoneMinder/ZoneMinder) as video surveillance center 
- [ ] Add [WatchTower](https://containrrr.dev/watchtower/) to automatically update all the containers if their image is changed
- [ ] Add [Mosquitto](https://hub.docker.com/_/eclipse-mosquitto) as MQTT broker
- [ ] Add [NextCloud](https://hub.docker.com/_/nextcloud) as file sharing center
- [ ] Test on actual Docker swarm with multiple nodes
- [ ] Benchmark the hardware requirements with full setup using metrics from Prometheus
- [ ] Write README about how to deploy new versions of any service\

Yea.. that's a lot of todos..

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
