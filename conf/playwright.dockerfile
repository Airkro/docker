# syntax=docker/dockerfile:1.5

FROM mcr.microsoft.com/playwright as browser
RUN <<EOF

apt-get update
apt-get install --no-install-recommends --fix-missing -y zip
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*

npm i -g npm@10 @playwright/test
npm cache clean --force

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
