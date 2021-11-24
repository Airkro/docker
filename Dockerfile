FROM node:lts-alpine as latest
RUN apk --no-cache add git openssh zip

FROM node:lts-slim as imagemin
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y git zip autoconf automake && apt-get clean && rm -rf /var/lib/apt/lists/*

FROM node:lts-slim as python3
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y git zip autoconf automake python3 python3-pip && apt-get clean && rm -rf /var/lib/apt/lists/*

FROM mcr.microsoft.com/playwright:focal as playwright
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y zip autoconf automake && apt-get clean && rm -rf /var/lib/apt/lists/* && npx playwright install && npm cache clean --force

FROM mcr.microsoft.com/playwright:focal as fonts
RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y zip autoconf automake fonts-roboto fonts-noto-cjk && apt-get clean && rm -rf /var/lib/apt/lists/* && npx playwright install && npm cache clean --force