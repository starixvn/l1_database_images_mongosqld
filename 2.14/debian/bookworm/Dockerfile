FROM debian:bookworm-slim AS base
ARG UID=329
ARG GID=329
ARG UNAME=mongodb
ARG GNAME=mongodb

RUN groupadd --system --gid ${GID} -- ${GNAME} \
    && useradd --no-log-init \
    --no-create-home --home-dir /app \
    --uid ${UID} --gid ${GID} --no-user-group \
    --shell /usr/sbin/nologin --password '*' \
    -- ${UNAME} \
    && install --directory --mode 2770 --owner ${UID} --group ${UID} -- /app

FROM base as download
ARG VERSION
RUN apt update \
    && apt install --no-install-recommends -y curl ca-certificates
RUN curl https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian12-v${VERSION:-2.14.12}.tgz -o /tmp/mongodb-bi.tgz \
    && tar -xvzf /tmp/mongodb-bi.tgz -C /tmp --strip-components=1

FROM base
ARG UID=329
ARG GID=329

RUN apt update \
    && apt upgrade -y \
    && rm -rf /var/lib/apt/lists/*
RUN apt update \
    && apt install --no-install-recommends -y libssl-dev libgssapi-krb5-2 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=download /tmp/bin/mongosqld /usr/local/bin/mongosqld

WORKDIR /app
USER ${UID}:${GID}
COPY --chown=${UID}:${GID} docker-entrypoint.sh mongosqld.conf /app/
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["mongosqld"]
