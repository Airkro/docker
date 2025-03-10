# syntax=docker/dockerfile:1.5

FROM electronuserland/builder:wine AS electron-builder-wine

ENV PNPM_HOME=/usr/local/bin

RUN <<EOF

npm i -g npm@10
npm i -g @antfu/ni
npm i -g corepack
rm -rf /root/.npm/_cacache
npm cache clean --force
corepack enable pnpm
corepack enable yarn
corepack enable npm
corepack prepare npm@latest --activate
corepack prepare yarn@1.22.22 --activate
corepack prepare pnpm@latest --activate

EOF
