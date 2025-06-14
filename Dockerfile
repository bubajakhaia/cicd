FROM node:16.0.0
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT ["sh", "-c", "npm run start -- --port ${PORT}"]
