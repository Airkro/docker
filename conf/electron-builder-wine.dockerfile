FROM electronuserland/builder:wine AS electron-builder-wine

ENV XDG_DATA_HOME=/home/.share
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME:$PATH"

RUN <<EOF

npm i -g npm@11.18.0
npm i -g @antfu/ni
npm i -g corepack
rm -rf /root/.npm/_cacache
npm cache clean --force
corepack enable pnpm
corepack enable yarn
corepack enable npm
corepack prepare npm@11.18.0 --activate
corepack prepare yarn@1.22.22 --activate
corepack prepare pnpm@10.34.4 --activate

EOF

RUN pnpm config set storeDir /home/.share/pnpm/store 
