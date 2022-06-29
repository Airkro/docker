FROM node:lts-alpine as latest
RUN apk --no-cache add git openssh zip && npm i -g npm && npm cache clean --force

FROM latest as bring-it
RUN npm i -g npm && npm i @bring-it/cli -g && npm cache clean --force

FROM node:lts-slim as imagemin
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y git zip autoconf automake && apt-get clean && rm -rf /var/lib/apt/lists/* && npm i -g npm && npm cache clean --force

FROM node:lts-slim as python3
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y git zip python3 python3-pip && apt-get clean && rm -rf /var/lib/apt/lists/* && npm i -g npm && npm cache clean --force

FROM mcr.microsoft.com/playwright:focal as playwright
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y zip && apt-get autoclean && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/* && npm i -g npm && npm cache clean --force

FROM mcr.microsoft.com/playwright:focal as deploy
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y zip && apt-get autoclean && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/* && npm i -g npm @bring-it/cli -g && npm cache clean --force

FROM mcr.microsoft.com/playwright:focal as browser
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y zip fonts-roboto fonts-noto-cjk && apt-get autoclean && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/* && npm i -g npm && npm cache clean --force
