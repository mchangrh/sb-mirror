FROM alpine:latest
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp

RUN apk add --no-cache sqlite
COPY . /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]