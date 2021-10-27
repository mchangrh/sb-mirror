FROM debian:bullseye-slim
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp

RUN apt update && apt install --no-install-recommends -y rsync

CMD rsync --no-detach --daemon