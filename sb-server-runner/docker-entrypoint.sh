#!/bin/sh

git clone https://github.com/ajayyy/SponsorBlockServer.git /app
if [[ $DBINIT ]]
do
  echo {"mode": "init-db-only"} > /app/config.json
fi
npm start