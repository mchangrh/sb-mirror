#!/bin/sh
echo "Licenced under the MIT Licence https://github.com/ajayyy/SponsorBlockServer" 

git clone https://github.com/ajayyy/SponsorBlockServer.git --depth 1
mv ./SponsorBlockServer/* ./SponsorBlockServer/.* /app/ 2>/dev/null
rm -rf ./SponsorBlockServer
mv /build/node_modules /app/node_modules

if [ ! -z $DBINIT ]
then
  echo '{"mode": "init-db-and-exit"}' > /app/config.json
fi
npm start
if [ ! -z $DBINIT ]; then
  mkdir -p /export
  cp /app/databases/sponsorTimes.db /export/sponsorTimes.db
fi