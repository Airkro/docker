ARG PLAYWRIGHT_VERSION=1.61.1

FROM mcr.microsoft.com/playwright:v${PLAYWRIGHT_VERSION}-noble AS browser

ENV XDG_DATA_HOME=/home/.share
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME:$PATH"

RUN <<EOF

apt-get update
apt-get install --no-install-recommends --fix-missing -y zip
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*

EOF

RUN <<EOF

npm i -g npm@npm@11.18.0
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

RUN pnpm config set storeDir /home/.share/pnpm/store --global

RUN pnpm i -g @playwright/test@${PLAYWRIGHT_VERSION} playwright-core@${PLAYWRIGHT_VERSION} playwright@${PLAYWRIGHT_VERSION}

RUN <<EOF

cat <<EOT > noto-sc.txt
https://github.com/notofonts/noto-cjk/raw/main/Sans/Variable/OTF/Mono/NotoSansMonoCJKsc-VF.otf
https://github.com/notofonts/noto-cjk/raw/main/Serif/Variable/OTF/NotoSerifCJKsc-VF.otf
https://github.com/notofonts/noto-cjk/raw/main/Sans/Variable/OTF/NotoSansCJKsc-VF.otf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/unhinted/variable-ttf/NotoSans-Italic%5Bwdth,wght%5D.ttf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSerif/unhinted/variable-ttf/NotoSerif-Italic%5Bwdth,wght%5D.ttf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/unhinted/variable-ttf/NotoSans%5Bwdth,wght%5D.ttf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSerif/unhinted/variable-ttf/NotoSerif%5Bwdth,wght%5D.ttf
https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSansMono/unhinted/variable-ttf/NotoSansMono%5Bwdth,wght%5D.ttf
EOT

wget -i noto-sc.txt -P /usr/local/share/fonts/
rm noto-sc.txt
fc-cache -f -v

EOF

FROM browser AS sample

RUN pnpm i -g @bring-it/sample

WORKDIR /workspace

CMD [ "bring-it", "sample" ]
