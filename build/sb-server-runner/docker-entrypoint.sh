#!/bin/sh
echo "Licenced under the MIT Licence https://github.com/ajayyy/SponsorBlockServer" 

git clone https://github.com/ajayyy/SponsorBlockServer.git --depth 1 /app
npm ci

if [ -z $DBINIT ]
then
  echo '{"mode": "init-db-and-exit"}' > /app/config.json
fi
npm start
if [ -z $DBINIT ]; then
  cp /app/databases/sponsorTimes.db /export/sponsorTimes.db
fi