!#/bin/bash
set -x

REGISTRY_URL=hub.lumigame.com
IMAGE_NAME=mongosqld
IMAGE_MINOR_VERSION=2.14
IMAGE_PATCH_VERSION=2.14.12

docker build \
    --file ${IMAGE_MINOR_VERSION}/Dockerfile \
    --tag ${REGISTRY_URL}/ldb/${IMAGE_NAME}:${IMAGE_MINOR_VERSION} \
    --build-arg "VERSION=${IMAGE_PATCH_VERSION}" \
    -- ${IMAGE_MINOR_VERSION}
docker tag ${REGISTRY_URL}/ldb/${IMAGE_NAME}:${IMAGE_MINOR_VERSION} ${REGISTRY_URL}/ldb/${IMAGE_NAME}:latest


for DEBIAN_DISTRO in bookworm bullseye buster; do
    docker build \
        --file ${IMAGE_MINOR_VERSION}/debian/${DEBIAN_DISTRO}/Dockerfile \
        --tag ${REGISTRY_URL}/ldb/${IMAGE_NAME}:${IMAGE_MINOR_VERSION}-${DEBIAN_DISTRO} \
        --build-arg "VERSION=${IMAGE_PATCH_VERSION}" \
        -- ${IMAGE_MINOR_VERSION}
    docker tag ${REGISTRY_URL}/ldb/${IMAGE_NAME}:${IMAGE_MINOR_VERSION}-${DEBIAN_DISTRO} ${REGISTRY_URL}/ldb/${IMAGE_NAME}:latest-${DEBIAN_DISTRO}
done


for UBUNTU_DISTRO in focal jammy; do
    docker build \
        --file ${IMAGE_MINOR_VERSION}/ubuntu/${UBUNTU_DISTRO}/Dockerfile \
        --tag ${REGISTRY_URL}/ldb/${IMAGE_NAME}:${IMAGE_MINOR_VERSION}-${UBUNTU_DISTRO} \
        --build-arg "VERSION=${IMAGE_PATCH_VERSION}" \
        -- ${IMAGE_MINOR_VERSION}
    docker tag ${REGISTRY_URL}/ldb/${IMAGE_NAME}:${IMAGE_MINOR_VERSION}-${UBUNTU_DISTRO} ${REGISTRY_URL}/ldb/${IMAGE_NAME}:latest-${UBUNTU_DISTRO}
done

docker push --all-tags ${REGISTRY_URL}/ldb/${IMAGE_NAME}

git reset HEAD -- . \
    && git add . \
    && git commit -m "chore(publish): \`${IMAGE_NAME}:${IMAGE_PATCH_VERSION}\`"

git push origin --delete "${IMAGE_MINOR_VERSION}"; \
    git tag -d "${IMAGE_MINOR_VERSION}"; \
    git tag -s "${IMAGE_MINOR_VERSION}" -m ""
git push origin --delete "${IMAGE_PATCH_VERSION}"; \
    git tag -d "${IMAGE_PATCH_VERSION}"; \
    git tag -s "${IMAGE_PATCH_VERSION}" -m ""
git push origin "${IMAGE_MINOR_VERSION}" "${IMAGE_PATCH_VERSION}"
