#!/bin/sh

git clone https://github.com/ajayyy/SponsorBlockServer.git --depth 1 /app
npm ci

if [ -z $DBINIT ]
then
  echo '{"mode": "init-db-and-exit"}' > /app/config.json
fi
npm start
cp /app/databases/sponsorTimes.db /export/sponsorTimes.db