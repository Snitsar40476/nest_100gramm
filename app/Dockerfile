FROM node:20-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

COPY bash/entrypoint.sh /usr/src/app/bash/entrypoint.sh
RUN chmod +x /usr/src/app/bash/entrypoint.sh

EXPOSE 5000

ENTRYPOINT ["/usr/src/app/bash/entrypoint.sh"]
