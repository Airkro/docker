# syntax=docker/dockerfile:1.5

FROM openjdk:11 as qci_worker

RUN <<EOL
apt-get update
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install --no-install-recommends --fix-missing -y nodejs wget zip git python3.9 python3-pip
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*
EOL

RUN mkdir -p /root/codingci/tools

WORKDIR /root/codingci/tools

RUN <<EOL
curl -fL -o jenkins.war https://public-files.coding.net/public-files/coding-ci/jenkins.war?version=2.293-cci-v2.6
chmod +x jenkins.war
curl -fL -o jenkinsHome.zip https://coding-public-generic.pkg.coding.net/cci/release/jenkinsHome.zip?version=latest
unzip -o jenkinsHome.zip
rm jenkinsHome.zip
EOL

RUN <<EOL
pip3 install qci_worker -i https://coding-public-pypi.pkg.coding.net/cci/worker/simple
qci_worker version

qci_worker config JENKINS_HOST=0.0.0.0
qci_worker config JENKINS_PORT=15740
qci_worker config JENKINS_ENCODING='UTF-8'
EOL

EXPOSE 15740
