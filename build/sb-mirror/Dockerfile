FROM alpine:latest
EXPOSE 873/tcp

RUN apk add --no-cache sqlite curl jq rsync 
COPY . /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]