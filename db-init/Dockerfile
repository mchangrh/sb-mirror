FROM node:alpine
WORKDIR /app
RUN apk add --no-cache git python make g++
RUN git clone https://github.com/ajayyy/SponsorBlockServer.git /app
RUN echo {"mode": "init-db-only"} > /app/config.json
run npm start