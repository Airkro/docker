# syntax=docker/dockerfile:1.6

ARG PLAYWRIGHT_VERSION=1.55.0

FROM mcr.microsoft.com/playwright:v${PLAYWRIGHT_VERSION}-noble AS browser

ENV PNPM_HOME=/usr/local/bin

RUN <<EOF

apt-get update
apt-get install --no-install-recommends --fix-missing -y zip
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*

EOF

RUN <<EOF

npm i -g npm@11
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
pnpm config set storeDir /home/.share/pnpm/store 

EOF

RUN pnpm i -g @playwright/test@${PLAYWRIGHT_VERSION} playwright-core@${PLAYWRIGHT_VERSION}

RUN <<EOF

cat <<EOT > noto-sans.txt
https://github.com/notofonts/noto-cjk/raw/main/Sans/Variable/OTF/Mono/NotoSansMonoCJKsc-VF.otf
https://github.com/notofonts/noto-cjk/raw/main/Sans/Variable/OTF/NotoSansCJKsc-VF.otf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/full/variable-ttf/NotoSans-Italic[wdth,wght].ttf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/full/variable-ttf/NotoSans[wdth,wght].ttf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSansMono/unhinted/variable-ttf/NotoSansMono[wdth,wght].ttf
EOT

wget -i noto-sans.txt -P /usr/local/share/fonts/
rm noto-sans.txt
fc-cache -f -v

EOF

FROM browser AS sample

RUN pnpm install --global @bring-it/sample

WORKDIR /workspace

CMD [ "bring-it", "sample" ]
