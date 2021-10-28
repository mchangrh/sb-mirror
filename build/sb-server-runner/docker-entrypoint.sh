#!/bin/sh
echo "Licenced under the MIT Licence https://github.com/ajayyy/SponsorBlockServer" 

curl -sLO https://github.com/ajayyy/SponsorBlockServer/archive/refs/heads/master.zip && unzip master.zip -q
mv ./SponsorBlockServer-master/* ./SponsorBlockServer-master/.* /app/ 2>/dev/null
rm -rf ./SponsorBlockServer-master

mv /build/node_modules /app/node_modules

if [ -n "$DBINIT" ]; then echo '{"mode": "init-db-and-exit"}' > /app/config.json; fi
npm start
if [ -n "$DBINIT" ]; then mkdir -p /export && cp /app/databases/sponsorTimes.db /export/sponsorTimes.db; fi