FROM debian:bullseye-slim
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp

RUN apt update && apt install -y rsync sqlite3 wget
COPY . /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]