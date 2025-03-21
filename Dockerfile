ARG PROFILARR_VERSION=1.0.1
ARG BUILD_FROM
ARG BUILD_ARCH

FROM node:18-bullseye AS builder

ARG PROFILARR_VERSION
ARG BUILD_FROM
ARG BUILD_ARCH

RUN echo "Profilarr version: ${PROFILARR_VERSION}" && \
    echo "Build architecture: ${BUILD_ARCH}" && \
    echo "Build from: ${BUILD_FROM}"

RUN apt-get update && apt-get install -y wget tar
RUN wget https://github.com/Dictionarry-Hub/profilarr/archive/refs/tags/${PROFILARR_VERSION}.tar.gz
RUN mkdir -p /profilarr && \
    tar -xvf ${PROFILARR_VERSION}.tar.gz -C /profilarr --strip-components=1
WORKDIR /profilarr/frontend

RUN npm ci && npm run build
RUN cd .. && \
    mkdir -p dist/backend dist/static && \
    cp -r frontend/dist/* dist/static/ && \
    cp -r backend/* dist/backend/ && \
    cp backend/requirements.txt dist/

FROM ${BUILD_FROM}

ARG PROFILARR_VERSION
ARG BUILD_FROM
ARG BUILD_ARCH

RUN echo "Profilarr version: ${PROFILARR_VERSION}" && \
    echo "Build architecture: ${BUILD_ARCH}"

# Install dependencies
RUN apk update && \
    apk add --no-cache git python3 tzdata py3-six py3-requests py3-pip gcc python3-dev musl-dev

WORKDIR /usr/bin/profilarr

# Copy Profilarr
COPY --from=builder /profilarr/dist/backend/app ./app
COPY --from=builder /profilarr/dist/static ./app/static
COPY --from=builder /profilarr/dist/requirements.txt .

RUN pip3 install "cython<3.0.0" && \
    pip3 install wheel && \
    pip3 install --no-build-isolation "pyyaml==5.4.1"

RUN pip3 install --no-cache-dir -r requirements.txt && \
    apk del py3-pip gcc python3-dev musl-dev

# Copy root filesystem
COPY rootfs /
