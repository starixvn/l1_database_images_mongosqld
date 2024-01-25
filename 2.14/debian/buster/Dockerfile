FROM debian:buster-slim AS base

FROM base as download
ARG VERSION
RUN apt update \
    && apt install --no-install-recommends -y curl ca-certificates
RUN curl https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian10-v${VERSION:-2.14.12}.tgz -o /tmp/mongodb-bi.tgz \
    && tar -xvzf /tmp/mongodb-bi.tgz -C /tmp --strip-components=1

FROM base
RUN mkdir -p /app
WORKDIR /app
RUN apt update \
    && apt install --no-install-recommends -y libssl-dev libgssapi-krb5-2 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=download /tmp/bin/mongosqld /usr/local/bin/mongosqld
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["mongosqld"]
