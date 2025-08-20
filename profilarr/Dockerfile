ARG PROFILARR_VERSION=v1.1
ARG BUILD_FROM
ARG BUILD_ARCH

FROM node:24-bookworm AS builder

ARG PROFILARR_VERSION
ARG BUILD_FROM
ARG BUILD_ARCH

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends wget tar && \
    wget --progress=dot:giga https://github.com/Dictionarry-Hub/profilarr/archive/refs/tags/${PROFILARR_VERSION}.tar.gz && \
    mkdir -p /profilarr && \
    tar -xvf ${PROFILARR_VERSION}.tar.gz -C /profilarr --strip-components=1

WORKDIR /profilarr/frontend

RUN npm ci && npm run build

WORKDIR /profilarr

RUN mkdir -p dist/backend dist/static && \
    cp -r frontend/dist/* dist/static/ && \
    cp -r backend/* dist/backend/ && \
    cp backend/requirements.txt dist/

# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ARG PROFILARR_VERSION
ARG BUILD_FROM
ARG BUILD_ARCH

RUN echo "Profilarr version: ${PROFILARR_VERSION}" && \
    echo "Build architecture: ${BUILD_ARCH}"

# Install dependencies
# hadolint ignore=DL3018
RUN apk update && \
    apk add --no-cache git python3 tzdata py3-six py3-requests py3-pip gcc python3-dev musl-dev

WORKDIR /usr/bin/profilarr

# Copy Profilarr
COPY --from=builder /profilarr/dist/backend/app ./app
COPY --from=builder /profilarr/dist/static ./app/static
COPY --from=builder /profilarr/dist/requirements.txt .

# hadolint ignore=DL3013
RUN pip3 install --break-system-packages --no-cache-dir "cython>=3.0.0" "wheel" && \
    pip3 install --break-system-packages --no-cache-dir --no-build-isolation "pyyaml>=6.0" && \
    pip3 install --break-system-packages --no-cache-dir -r requirements.txt && \
    apk del py3-pip gcc python3-dev musl-dev

# Copy root filesystem
COPY rootfs /

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Marvin Haschker <https://github.com/123marvin123/>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Marvin Haschker <https://github.com/123marvin123/>" \
    org.opencontainers.image.authors="Marvin Haschker <https://github.com/123marvin123/>" \
    org.opencontainers.image.licenses="Apache License 2.0" \
    org.opencontainers.image.url="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
