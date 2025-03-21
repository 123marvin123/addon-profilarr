ARG PROFILARR_VERSION=1.0.1
ARG BUILD_FROM
ARG BUILD_ARCH

FROM node:18-bullseye AS builder

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
RUN apk update && \
    apk add --no-cache git=2.49.0-r0 python3=3.12.9-r0 tzdata=2025a-r0 py3-six=1.17.0-r0 py3-requests=2.32.3-r0 py3-pip=25.0.1-r0 gcc=14.2.0-r5 python3-dev=3.12.9-r0 musl-dev=1.2.5-r10

WORKDIR /usr/bin/profilarr

# Copy Profilarr
COPY --from=builder /profilarr/dist/backend/app ./app
COPY --from=builder /profilarr/dist/static ./app/static
COPY --from=builder /profilarr/dist/requirements.txt .


RUN pip3 install --no-cache-dir "cython==3.0.12" "wheel==0.45.1" && \
    pip3 install --no-cache-dir --no-build-isolation "pyyaml==5.4.1" && \
    pip3 install --no-cache-dir -r requirements.txt && \
    apk del py3-pip gcc python3-dev musl-dev

# Copy root filesystem
COPY rootfs /
