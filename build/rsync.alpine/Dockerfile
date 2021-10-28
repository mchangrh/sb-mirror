FROM alpine:latest
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp
# add mchangrh's repo
COPY ./michael@mchang.name.rsa.pub /etc/apk/keys/
RUN echo "https://alpine.mchang.icu/repo" >> /etc/apk/repositories
RUN apk add --no-cache rsync=3.2.3-r5

CMD rsync --no-detach --daemon