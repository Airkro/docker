FROM node:lts-alpine as latest
RUN apk --no-cache --update add git zip docker-cli
RUN npm i -g npm@10 && npm i -g @antfu/ni && npm i -g corepack \ 
  && rm -rf /root/.npm/_cacache && npm cache clean --force \
  && corepack enable npm  && corepack prepare npm@10.5.2 --activate \
  && corepack enable yarn && corepack prepare yarn@1.22.22 --activate \
  && corepack enable pnpm && corepack prepare pnpm@9.0.5 --activate \
  && SHELL=bash pnpm setup \ 
  && source ~/.bashrc

FROM latest as ssh
RUN apk --no-cache --update add openssh

FROM latest as sentry
RUN npm i -g @sentry/cli --unsafe-perm && rm -rf /root/.npm/_cacache && npm cache clean --force

FROM latest as python3
RUN apk --no-cache --update add python3 py3-pip

FROM latest as cocoapods
RUN apk add --no-cache --update ruby ruby-dev libffi-dev g++ make \
  && gem install cocoapods coding-push --no-document \
  && rm -rf /usr/lib/ruby/gems/*/cache/* \
  && apk del ruby-dev libffi-dev g++ make
RUN pod setup --allow-root

FROM latest as mp-wechat-ci
RUN npm i -g miniprogram-ci && rm -rf /root/.npm/_cacache && npm cache clean --force

FROM python3 as mp-alipay-ci
RUN apk --no-cache --update add make
RUN npm i -g minidev && rm -rf /root/.npm/_cacache && npm cache clean --force

FROM python3 as mp-ci
RUN apk --no-cache --update add make
RUN npm i -g minidev miniprogram-ci && rm -rf /root/.npm/_cacache && npm cache clean --force
