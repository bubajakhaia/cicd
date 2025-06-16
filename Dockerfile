FROM node:7.8.0
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT ["sh", "-c", "npm run start -- --port ${PORT}"]
