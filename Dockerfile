FROM node:slim

WORKDIR /app

ADD index.js index.js
ADD package-lock.json package-lock.json

RUN npm install -g npm@10.5.2
RUN npm install ioredis

ENTRYPOINT [ "node" ]

CMD [ "index.js" ]