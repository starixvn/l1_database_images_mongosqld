!#/bin/bash
set -x

REGISTRY_URL=hub.lumigame.com
MONGOSQLD_VERSION=2.14
MONGOSQLD_LATEST=2.14
MONGOSQLD_BINARY_VERSION=2.14.12

docker build \
    --file ${MONGOSQLD_VERSION}/Dockerfile \
    --tag ${REGISTRY_URL}/ldb/mongosqld:${MONGOSQLD_VERSION} \
    --build-arg "VERSION=${MONGOSQLD_BINARY_VERSION}" \
    -- ${MONGOSQLD_VERSION}
docker tag ${REGISTRY_URL}/ldb/mongosqld:${MONGOSQLD_LATEST} ${REGISTRY_URL}/ldb/mongosqld:latest


for DEBIAN_DISTRO in bookworm bullseye buster; do
    docker build \
        --file ${MONGOSQLD_VERSION}/debian/${DEBIAN_DISTRO}/Dockerfile \
        --tag ${REGISTRY_URL}/ldb/mongosqld:${MONGOSQLD_VERSION}-${DEBIAN_DISTRO} \
        --build-arg "VERSION=${MONGOSQLD_BINARY_VERSION}" \
        -- ${MONGOSQLD_VERSION}
    docker tag ${REGISTRY_URL}/ldb/mongosqld:${MONGOSQLD_LATEST}-${DEBIAN_DISTRO} ${REGISTRY_URL}/ldb/mongosqld:latest-${DEBIAN_DISTRO}
done

docker push -a ${REGISTRY_URL}/ldb/mongosqld
