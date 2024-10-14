FROM node:slim as nodejs
WORKDIR /app
ADD nodejs/index.js index.js
ADD nodejs/package-lock.json package-lock.json
RUN npm install -g npm@10.5.2
RUN npm install ioredis
ENTRYPOINT [ "node" ]
CMD [ "index.js" ]

FROM maven:3.8.7 as maven
WORKDIR /build
ADD java/demo/src ./src
ADD java/demo/pom.xml ./pom.xml
RUN mvn clean package
RUN mvn assembly:assembly -DdescriptorId=jar-with-dependencies

FROM openjdk:alpine as demo
WORKDIR /app
COPY --from=maven build/target/demo-1.0-SNAPSHOT-jar-with-dependencies.jar ./demo.jar
RUN chmod +x demo.jar
ENTRYPOINT ["java","-jar","/app/demo.jar"]

FROM debian:12-slim as toolbox
RUN apt update && apt install -y lsb-release vim curl gpg telnet net-tools\
    wget tree jq yq python3-pip python3-ipython python3-requests\
    python3-rediscluster python3-hiredis python3-redis python3-pamqp\
    python3-virtualenv pipenv nodejs npm
RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list
RUN apt install redis -y
ENTRYPOINT [ "sleep" ]
CMD [ "infinity" ]