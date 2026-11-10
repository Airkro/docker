FROM node:lts-alpine AS latest
RUN apk --no-cache --update add git zip curl wget jq ripgrep

RUN mkdir -p /home/.share/pnpm /mnt

ENV XDG_DATA_HOME=/home/.share
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME/bin:$PATH"

RUN <<EOF
set -eu

npm i -g npm@latest
npm i -g @antfu/ni

# Node 25+ 不再自带 corepack；先清掉基础镜像已有的 shim，否则 npm 全局安装会报 EEXIST
npm_bin="$(npm config get prefix)/bin"
rm -f "$npm_bin/corepack" "$npm_bin/pnpm" "$npm_bin/pnpx" "$npm_bin/yarn" "$npm_bin/yarnpkg"
npm i -g corepack@latest

rm -rf /root/.npm/_cacache
npm cache clean --force

corepack enable pnpm
corepack enable yarn
corepack prepare yarn@1.22.22 --activate
corepack prepare pnpm@latest --activate

EOF

RUN pnpm config set storeDir /home/.share/pnpm/store --global

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
RUN apk --no-cache --update add python3 py3-pip uv

FROM latest AS rust
RUN apk add --no-cache --update build-base
RUN apk add --no-cache --update rust cargo

FROM rust AS wasm
RUN apk add --no-cache binaryen wasm-pack wasm-bindgen brotli

FROM python3 AS mp-alipay-ci
RUN apk --no-cache --update add make
RUN pnpm i -g minidev

FROM latest AS mp-wechat-ci
RUN pnpm i -g miniprogram-ci
