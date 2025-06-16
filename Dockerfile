FROM python:3-alpine AS build

RUN apk update && \
    apk add --no-cache \
            knot-libs \
            git && \
    git clone https://gitlab.nic.cz/knot/knot-dns-rest.git && \
    mkdir venv && \
    cd venv && \
    python3 -m venv ./ && \
    . ./bin/activate && \
    python3 -m pip install --no-cache-dir \
            -r ../knot-dns-rest/requirements.txt && \
    python3 -m pip install ../knot-dns-rest

FROM python:3-alpine AS final

COPY --chmod=0755 ./entrypoint.sh /
COPY --from=build /venv /venv

RUN apk add --no-cache \
            knot-libs && \
    mkdir /var/log/knot_rest && \
    mkdir /var/lib/knot_rest

ENTRYPOINT [ "/bin/sh", "/entrypoint.sh" ]
