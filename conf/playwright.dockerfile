ARG PLAYWRIGHT_VERSION=1.65.0

FROM mcr.microsoft.com/playwright:v${PLAYWRIGHT_VERSION}-noble AS browser

ENV XDG_DATA_HOME=/home/.share
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME/bin:$PATH"

RUN <<EOF

apt-get update
apt-get install --no-install-recommends --fix-missing -y zip
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*

EOF

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

FROM browser AS browser-wasm

ARG WASM_PACK_VERSION=v0.15.1
ARG WASM_BINDGEN_VERSION=0.2.130

RUN <<EOF
set -eu

case "$(dpkg --print-architecture)" in
  amd64) wasm_arch=x86_64 ;;
  arm64) wasm_arch=aarch64 ;;
  *) echo "unsupported architecture" >&2; exit 1 ;;
esac

apt-get update
apt-get install --no-install-recommends --fix-missing -y rustc cargo binaryen brotli
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*

wasm_tmp=$(mktemp -d)
wget -qO- "https://github.com/wasm-bindgen/wasm-pack/releases/download/${WASM_PACK_VERSION}/wasm-pack-${WASM_PACK_VERSION}-${wasm_arch}-unknown-linux-musl.tar.gz" | tar -xz -C "$wasm_tmp"
wget -qO- "https://github.com/wasm-bindgen/wasm-bindgen/releases/download/${WASM_BINDGEN_VERSION}/wasm-bindgen-${WASM_BINDGEN_VERSION}-${wasm_arch}-unknown-linux-musl.tar.gz" | tar -xz -C "$wasm_tmp"
find "$wasm_tmp" -type f -name wasm-pack -exec install -m 755 {} /usr/local/bin/ \;
find "$wasm_tmp" -type f -name wasm-bindgen -exec install -m 755 {} /usr/local/bin/ \;
rm -rf "$wasm_tmp"
wasm-pack --version
wasm-bindgen --version

EOF
