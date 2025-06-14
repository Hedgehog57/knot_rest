Docker implementation for knot-dns-rest project by jan.hak@nic.cz
Original code taken from https://gitlab.nic.cz/knot/knot-dns-rest

Images are based on Debian Bookworm and python 3.13
Shoud be used behind reverse proxy.

Image creation:
```
docker build -t knot_rest:0.0.3 ./
```

Container creation:
```
# by docker
docker-compose up -d
# by podman
podman compose up -d
```