FROM electronuserland/builder:wine AS electron-builder-wine

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
