FROM debian:buster
RUN apt update
RUN apt install -y rsyslog nano curl
WORKDIR /home/mongobi
RUN curl -o mbi.tgz https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian92-v2.14.14.tgz
RUN tar -xvzf mbi.tgz && rm mbi.tgz && mv mongodb-bi-linux-x86_64-debian92-v2.14.14 mbi
WORKDIR /home/mongobi/mbi
RUN mkdir /logs
RUN install -m755 bin/mongo* /usr/local/bin/

ENV MONGODB_HOST=mongodb
ENV MONGODB_PORT=27017
ENV MONGODB_USERNAME=''
ENV MONGODB_PASSWORD=''

EXPOSE 3307

RUN service rsyslog start

CMD ["mongosqld","--mongo-uri","${MONGODB_HOST}:${MONGODB_PORT}?connect=direct","--auth","--mongo-username","${MONGODB_USERNAME}","--mongo-password","${MONGODB_PASSWORD}","--addr","0.0.0.0:3307"]
