# syntax=docker/dockerfile:1.6

FROM electronuserland/builder:wine AS electron-builder-wine

ENV XDG_DATA_HOME=/home/.share
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME:$PATH"

RUN <<EOF

npm i -g npm@latest
npm i -g @antfu/ni
npm i -g corepack
rm -rf /root/.npm/_cacache
npm cache clean --force
corepack enable pnpm
corepack enable yarn
corepack enable npm
corepack prepare npm@latest --activate
corepack prepare yarn@1.22.22 --activate
corepack prepare pnpm@10.33.4 --activate
pnpm config set storeDir /home/.share/pnpm/store 

EOF
