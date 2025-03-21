ARG PROFILARR_VERSION=v1.0.1
ARG BUILD_FROM
ARG BUILD_ARCH

FROM node:23-bullseye AS builder

ARG PROFILARR_VERSION
ARG BUILD_FROM
ARG BUILD_ARCH

RUN apt-get update && apt-get install -y --no-install-recommends wget=1.21-1+deb11u1 tar=1.34+dfsg-1+deb11u1 && \
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
RUN pip3 install --no-cache-dir "cython<3.0.0" "wheel" && \
    pip3 install --no-cache-dir --no-build-isolation "pyyaml==5.4.1" && \
    pip3 install --no-cache-dir -r requirements.txt && \
    apk del py3-pip gcc python3-dev musl-dev

# Copy root filesystem
COPY rootfs /
