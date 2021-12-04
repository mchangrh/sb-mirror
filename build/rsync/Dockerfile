FROM alpine:3.15
MAINTAINER "Michael Chang <michael@mchang.name>"
EXPOSE 873/tcp
# add mchangrh's repo
COPY ./michael@mchang.name.rsa.pub /etc/apk/keys/
RUN apk add --no-cache rsync>3.2.3-r6 --repository https://alpine.mchang.icu/repo

CMD rsync --no-detach --daemon