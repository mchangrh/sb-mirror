FROM debian:bullseye-slim
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp

RUN apt update && apt install -y --no-install-recommends rsync sqlite3 curl ca-certificates jq cron
COPY . /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]