FROM node:lts-alpine AS latest
RUN apk --no-cache --update add git zip curl
RUN apk --no-cache --update add docker-cli docker-cli-compose

RUN mkdir -p /home/.share /home/.state /home/.share/pnpm /tmp/.cache /mnt

ENV XDG_DATA_HOME=/home/.share
ENV XDG_STATE_HOME=/home/.state
ENV XDG_CACHE_HOME=/tmp/.cache
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME:$PATH"

RUN npm i -g npm@10 && npm i -g @antfu/ni && npm i -g corepack \ 
  && rm -rf /root/.npm/_cacache && npm cache clean --force \
  && corepack enable npm  && corepack prepare npm@latest --activate \
  && corepack enable yarn && corepack prepare yarn@1.22.22 --activate \
  && corepack enable pnpm && corepack prepare pnpm@latest --activate

WORKDIR /mnt

FROM latest AS ssh
RUN apk --no-cache --update add openssh

FROM latest AS github
RUN apk --no-cache --update add github-cli

FROM latest AS sentry
RUN pnpm i -g @sentry/cli

FROM latest AS python3
RUN apk --no-cache --update add python3 py3-pip

FROM latest AS cocoapods
RUN apk add --no-cache --update ruby ruby-dev libffi-dev g++ make \
  && gem install cocoapods coding-push --no-document \
  && rm -rf /usr/lib/ruby/gems/*/cache/* \
  && apk del ruby-dev libffi-dev g++ make
RUN pod setup --allow-root

FROM latest AS mp-wechat-ci
RUN pnpm i -g miniprogram-ci miniprogram-ci-v1@npm:miniprogram-ci@1

FROM python3 AS mp-alipay-ci
RUN apk --no-cache --update add make
RUN pnpm i -g minidev
