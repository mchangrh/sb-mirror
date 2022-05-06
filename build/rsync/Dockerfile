FROM alpine:3.15
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp
RUN apk add --no-cache rsync

CMD rsync --no-detach --daemon