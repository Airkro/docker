FROM node:lts-slim AS cnb-webide

RUN <<EOF

apt-get update
apt-get install -y git unzip wget curl openssh-server
apt clean

EOF

RUN mkdir -p /home/.share/pnpm /mnt

ENV XDG_DATA_HOME=/home/.share
ENV PNPM_HOME=/home/.share/pnpm
ENV PATH="$PNPM_HOME:$PATH"

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN <<EOF

code-server --install-extension adam-bender.commit-message-editor
code-server --install-extension bradlc.vscode-tailwindcss
code-server --install-extension dbaeumer.vscode-eslint
code-server --install-extension eamodio.gitlens
code-server --install-extension EditorConfig.EditorConfig
code-server --install-extension esbenp.prettier-vscode
code-server --install-extension MS-CEINTL.vscode-language-pack-zh-hans
code-server --install-extension pflannery.vscode-versionlens
code-server --install-extension PKief.material-icon-theme
code-server --install-extension redhat.vscode-yaml
code-server --install-extension stylelint.vscode-stylelint
code-server --install-extension tencent-cloud.coding-copilot
code-server --install-extension Vue.volar

EOF

COPY cnb/settings.json /root/.vscode-server/data/Machine/settings.json
COPY cnb/settings.json /root/.local/share/code-server/Machine/settings.json

RUN <<EOF

npm i -g npm@latest && npm i -g @antfu/ni && npm i -g corepack 
rm -rf /root/.npm/_cacache && npm cache clean --force 
corepack enable npm  && corepack prepare npm@latest --activate 
corepack enable yarn && corepack prepare yarn@1.22.22 --activate 
corepack enable pnpm && corepack prepare pnpm@latest --activate 
pnpm config set storeDir /home/.share/pnpm/store --global

EOF

WORKDIR /mnt

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
