FROM node:lts-alpine as latest
RUN apk --no-cache --update add git zip docker-cli
COPY --from=docker/compose-bin:latest /docker-compose /usr/bin/compose
RUN npm i -g npm@10 && rm -rf /root/.npm/_cacache && npm cache clean --force

FROM latest as ssh
RUN apk --no-cache --update add openssh

FROM latest as sentry
RUN npm i -g @sentry/cli --unsafe-perm && rm -rf /root/.npm/_cacache && npm cache clean --force

FROM latest as python3
RUN apk --no-cache --update add python3 py3-pip

FROM latest as mp-wechat-ci
RUN npm i -g miniprogram-ci && rm -rf /root/.npm/_cacache && npm cache clean --force

FROM python3 as mp-alipay-ci
RUN apk --no-cache --update add make
RUN npm i -g minidev && rm -rf /root/.npm/_cacache && npm cache clean --force

FROM python3 as mp-ci
RUN apk --no-cache --update add make
RUN npm i -g minidev miniprogram-ci && rm -rf /root/.npm/_cacache && npm cache clean --force
