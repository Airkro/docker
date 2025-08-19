FROM node:lts-alpine AS latest
RUN apk --no-cache --update add git zip curl

RUN mkdir -p /home/.share/pnpm /mnt

ENV XDG_DATA_HOME=/home/.share
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME:$PATH"

RUN npm i -g npm@latest && npm i -g @antfu/ni && npm i -g corepack \ 
  && rm -rf /root/.npm/_cacache && npm cache clean --force \
  && corepack enable npm  && corepack prepare npm@latest --activate \
  && corepack enable yarn && corepack prepare yarn@1.22.22 --activate \
  && corepack enable pnpm && corepack prepare pnpm@latest --activate \
  && pnpm config set storeDir /home/.share/pnpm/store 

WORKDIR /workspace

FROM latest AS docker
RUN apk --no-cache --update add docker-cli docker-cli-compose

FROM latest AS ssh
RUN apk --no-cache --update add openssh

FROM latest AS github
RUN apk --no-cache --update add github-cli

FROM latest AS sentry
RUN pnpm i -g @sentry/cli

FROM latest AS python3
RUN apk --no-cache --update add python3 py3-pip

FROM latest AS rust
RUN apk add --no-cache --update build-base
RUN apk add --no-cache --update rust cargo

FROM rust AS wasm
RUN apk add --no-cache binaryen wasm-pack wasm-bindgen brotli

FROM latest AS mp-wechat-ci
RUN pnpm i -g miniprogram-ci

FROM python3 AS mp-alipay-ci
RUN apk --no-cache --update add make
RUN pnpm i -g minidev
