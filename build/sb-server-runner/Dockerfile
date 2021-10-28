FROM node:lts-alpine as builder
WORKDIR /build
RUN apk add --no-cache python3 make g++ wget
RUN wget https://raw.githubusercontent.com/ajayyy/SponsorBlockServer/master/package.json
RUN wget https://raw.githubusercontent.com/ajayyy/SponsorBlockServer/master/package-lock.json
RUN npm ci

FROM node:lts-alpine
EXPOSE 8080/tcp
WORKDIR /app
RUN apk add --no-cache git
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY --from=builder /build/node_modules /build/node_modules
ENTRYPOINT /docker-entrypoint.sh
CMD ["sh"]