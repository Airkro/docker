# syntax=docker/dockerfile:1.5

FROM openjdk:11 AS qci_worker

RUN <<EOL
apt-get update
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install --no-install-recommends --fix-missing -y nodejs zip git python3.9 python3-pip
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*
EOL

RUN mkdir -p /root/coding-ci

WORKDIR /root/coding-ci

RUN <<EOL
curl -fL -o jenkins.war https://public-files.coding.net/public-files/coding-ci/jenkins.war?version=2.293-cci-2024.07.11-b2ecf92fa3955e9d3084bc31904a7b2ee6871e31
chmod +x jenkins.war
curl -fL -o jenkinsHome.zip https://public-files.coding.net/public-files/coding-ci/jenkinsHome.zip?version=2024.07.15-ce4ab3d240201ff2409820fb44810dbcdbf565d3
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

ENV CCI_TOKEN ''
ENV CCI_TEAM ''

CMD ["qci_worker cci_reg --token ${CCI_TOKEN} --server wss://${CCI_TEAM}.coding.net", "qci_worker up -d"]
ENTRYPOINT ["/bin/sh", "-c"]
