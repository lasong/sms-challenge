FROM node:8-alpine
MAINTAINER lasong

WORKDIR /usr/src/frontend
COPY package*.json ./
RUN yarn install
COPY . .
EXPOSE 4000

CMD ["yarn", "start"]
