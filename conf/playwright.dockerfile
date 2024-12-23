# syntax=docker/dockerfile:1.5

FROM mcr.microsoft.com/playwright:v1.49.0-jammy AS browser

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

RUN <<EOF

npm i -g @playwright/test@1.49.0 playwright-core@1.49.0
npm cache clean --force
pnpm i -g @playwright/test@1.49.0 playwright-core@1.49.0

EOF

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
