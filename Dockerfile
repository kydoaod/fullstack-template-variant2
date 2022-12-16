FROM node:18
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
WORKDIR /usr/src/app/backend
RUN npm install --legacy-peer-deps
WORKDIR /usr/src/app/frontend
RUN npm install --legacy-peer-deps
RUN npm run build
WORKDIR /usr/src/app/backend
RUN apt-get update
RUN apt-get -y install redis-server
RUN nohup redis-server &> redis.log &
EXPOSE 5001
EXPOSE 5000
CMD [ "node", "app.js" ]