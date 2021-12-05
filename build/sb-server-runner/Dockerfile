FROM node:lts-alpine as builder
WORKDIR /build
RUN apk add --no-cache python3 make g++ curl \
  && curl -sLO https://raw.githubusercontent.com/ajayyy/SponsorBlockServer/master/package.json \
  && curl -sLO https://raw.githubusercontent.com/ajayyy/SponsorBlockServer/master/package-lock.json \
  && npm ci

FROM node:lts-alpine
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 8080/tcp
WORKDIR /app
RUN apk add --no-cache git
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN git clone --depth 1 -b master https://github.com/ajayyy/SponsorBlockServer.git /app
COPY --from=builder /build/node_modules /app/node_modules
ENTRYPOINT /docker-entrypoint.sh
CMD ["sh"]
