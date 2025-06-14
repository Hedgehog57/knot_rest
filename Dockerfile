FROM python:bookworm AS build

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
            libknot13 \
            git && \
    apt-get clean && \
    git clone https://gitlab.nic.cz/knot/knot-dns-rest.git && \
    mkdir venv && \
    cd venv && \
    python3 -m venv ./ && \
    . ./bin/activate && \
    python3 -m pip install --no-cache-dir \
            -r ../knot-dns-rest/requirements.txt && \
    python3 -m pip install ../knot-dns-rest

FROM python:3-slim-bookworm AS final

COPY ./entrypoint.sh /
COPY --from=build /venv /venv

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
            libknot13 && \
    apt-get clean && \
    mkdir /var/log/knot_rest && \
    mkdir /var/lib/knot_rest && \
    chmod 755 /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
