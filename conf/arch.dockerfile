FROM node:lts-alpine as latest
RUN apk --no-cache --update add git zip
RUN apk --no-cache --update add docker-cli docker-cli-compose

ENV PNPM_HOME=/usr/local/bin

RUN npm i -g npm@10 && npm i -g @antfu/ni && npm i -g corepack \ 
  && rm -rf /root/.npm/_cacache && npm cache clean --force \
  && corepack enable npm  && corepack prepare npm@latest --activate \
  && corepack enable yarn && corepack prepare yarn@1.22.22 --activate \
  && corepack enable pnpm && corepack prepare pnpm@latest --activate

FROM latest as ssh
RUN apk --no-cache --update add openssh

FROM latest as sentry
RUN pnpm i -g @sentry/cli

FROM latest as python3
RUN apk --no-cache --update add python3 py3-pip

FROM latest as cocoapods
RUN apk add --no-cache --update ruby ruby-dev libffi-dev g++ make \
  && gem install cocoapods coding-push --no-document \
  && rm -rf /usr/lib/ruby/gems/*/cache/* \
  && apk del ruby-dev libffi-dev g++ make
RUN pod setup --allow-root

FROM latest as mp-wechat-ci
RUN pnpm i -g miniprogram-ci

FROM python3 as mp-alipay-ci
RUN apk --no-cache --update add make
RUN pnpm i -g minidev
