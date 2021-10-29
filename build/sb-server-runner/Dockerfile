FROM node:lts-alpine3.14 as builder
WORKDIR /build
RUN apk add --no-cache python3 make g++ curl \
  && curl -sLO https://raw.githubusercontent.com/ajayyy/SponsorBlockServer/master/package.json \
  && curl -sLO https://raw.githubusercontent.com/ajayyy/SponsorBlockServer/master/package-lock.json \
  && npm ci

FROM node:lts-alpine3.14
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 8080/tcp
WORKDIR /app
RUN apk add --no-cache curl git
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY --from=builder /build/node_modules /build/node_modules
ENTRYPOINT /docker-entrypoint.sh
CMD ["sh"]
