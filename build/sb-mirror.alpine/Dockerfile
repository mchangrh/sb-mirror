FROM mchangrh/rsync:alpine
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp

RUN apk add --no-cache sqlite curl jq
# add csvlint
RUN curl -sLO https://github.com/Clever/csvlint/releases/download/v0.3.0/csvlint-v0.3.0-linux-amd64.tar.gz \
  && tar -xf csvlint-v0.3.0-linux-amd64.tar.gz \
  && mv csvlint-v0.3.0-linux-amd64/csvlint /usr/local/bin/csvlint \
  && rm -rf csvlint-v0.3.0-linux-amd64 csvlint-v0.3.0-linux-amd64.tar.gz
COPY . /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]