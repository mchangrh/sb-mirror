FROM node:alpine
EXPOSE 8080/tcp
WORKDIR /app
RUN apk add --no-cache git python make g++
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh
CMD ["sh"]