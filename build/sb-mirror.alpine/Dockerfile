FROM mchangrh/rsync:alpine
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp

RUN apk add --no-cache sqlite curl jq
COPY . /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]