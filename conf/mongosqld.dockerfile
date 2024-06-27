# syntax=docker/dockerfile:1.5

FROM debian:stretch

RUN cat <<"END" > /etc/apt/sources.list
deb http://archive.debian.org/debian/ stretch main contrib non-free
deb http://archive.debian.org/debian/ stretch-backports main contrib non-free
deb http://archive.debian.org/debian-security/ stretch/updates main contrib non-free
END

RUN <<EOF
apt-get update
apt-get install --no-install-recommends --fix-missing -y curl ca-certificates
apt-get autoclean
apt-get clean
apt-get autoremove
rm -rf /var/lib/apt/lists/*
EOF

# rsyslog nano

# RUN mkdir /logs

WORKDIR /mongobi

ENV DIST_VER=mongodb-bi-linux-x86_64-debian92-v2.14.14
ENV DIST_URL=https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/${DIST_VER}.tgz

RUN curl -o mbi.tgz ${DIST_URL} \ 
  && tar -xvzf mbi.tgz \
  && install -m755 ${DIST_VER}/bin/mongo* /usr/local/bin/ \ 
  && rm -rf ${DIST_VER} mbi.tgz

EXPOSE 3307

# RUN service rsyslog start

CMD ["mongosqld", "--config", "/mongobi/config.yaml"]
