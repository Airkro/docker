# syntax=docker/dockerfile:1.5

FROM mcr.microsoft.com/playwright as browser
RUN <<EOF

apt-get update
apt-get install --no-install-recommends --fix-missing -y zip
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*

npm i -g npm@10
npm i -g @antfu/ni
npm i -g corepack
rm -rf /root/.npm/_cacache
npm cache clean --force
corepack enable pnpm
corepack enable yarn
corepack enable npm
corepack prepare npm@10.5.2 --activate
corepack prepare yarn@1.22.22 --activate
corepack prepare pnpm@9.0.2 --activate
npm cache clean --force
npm i -g @playwright/test
pnpm i -g @playwright/test

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
