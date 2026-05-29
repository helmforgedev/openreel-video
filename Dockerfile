# syntax=docker/dockerfile:1

FROM node:24-alpine AS source

ARG OPENREEL_VERSION=v0.4.0

RUN apk add --no-cache git
WORKDIR /src
RUN git clone --depth 1 --branch "${OPENREEL_VERSION}" https://github.com/Augani/openreel-video.git .

FROM node:24-alpine AS build

ENV CI=true
WORKDIR /app
COPY --from=source /src/ ./
RUN corepack enable && pnpm install --frozen-lockfile
RUN pnpm build

FROM nginxinc/nginx-unprivileged:1.29-alpine AS runtime

LABEL org.opencontainers.image.title="openreel-video" \
      org.opencontainers.image.description="OpenReel Video browser-based video editor served as a static web application" \
      org.opencontainers.image.vendor="HelmForge" \
      org.opencontainers.image.authors="HelmForge Team" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/helmforgedev/openreel-video"

COPY --from=build --chown=101:101 /app/apps/web/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
