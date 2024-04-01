!#/bin/bash
set -x

REGISTRY_URL=hub.lumigame.com
MONGOSQLD_IMAGE_NAME=mongosqld
MONGOSQLD_VERSION=2.14
MONGOSQLD_LATEST=2.14
MONGOSQLD_BINARY_VERSION=2.14.12

docker build \
    --file ${MONGOSQLD_VERSION}/Dockerfile \
    --tag ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:${MONGOSQLD_VERSION} \
    --build-arg "VERSION=${MONGOSQLD_BINARY_VERSION}" \
    -- ${MONGOSQLD_VERSION}
docker tag ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:${MONGOSQLD_LATEST} ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:latest


for DEBIAN_DISTRO in bookworm bullseye buster; do
    docker build \
        --file ${MONGOSQLD_VERSION}/debian/${DEBIAN_DISTRO}/Dockerfile \
        --tag ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:${MONGOSQLD_VERSION}-${DEBIAN_DISTRO} \
        --build-arg "VERSION=${MONGOSQLD_BINARY_VERSION}" \
        -- ${MONGOSQLD_VERSION}
    docker tag ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:${MONGOSQLD_LATEST}-${DEBIAN_DISTRO} ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:latest-${DEBIAN_DISTRO}
done


for UBUNTU_DISTRO in focal jammy; do
    docker build \
        --file ${MONGOSQLD_VERSION}/ubuntu/${UBUNTU_DISTRO}/Dockerfile \
        --tag ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:${MONGOSQLD_VERSION}-${UBUNTU_DISTRO} \
        --build-arg "VERSION=${MONGOSQLD_BINARY_VERSION}" \
        -- ${MONGOSQLD_VERSION}
    docker tag ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:${MONGOSQLD_LATEST}-${UBUNTU_DISTRO} ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}:latest-${UBUNTU_DISTRO}
done


docker push --all-tags ${REGISTRY_URL}/ldb/${MONGOSQLD_IMAGE_NAME}
