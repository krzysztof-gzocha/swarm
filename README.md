# Swarm
Docker swarm setup with basic applications.

# How to start?
- Install all required apps:
 - Docker
 - Docker compose
- Generate certificates (read certs/README.md for that)
- Prepare users list in `users` file
- Update `WEBPASSWORD` for PiHole in docker-compose.yml 
- Run `docker-compose up`
- Visit https://traefik.localhost/dashboard/
- Configure your router to point to Traefik, which will then distribute the request 
load to other services based on Host or other rules

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
