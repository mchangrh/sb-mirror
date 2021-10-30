#!/bin/sh
echo "Licenced under the MIT Licence https://github.com/ajayyy/SponsorBlockServer" 

git pull

if [ -n "$DBINIT" ]; then echo '{"mode": "init-db-and-exit"}' > /app/config.json; fi
npm start
if [ -n "$DBINIT" ]; then mkdir -p /export && cp /app/databases/sponsorTimes.db /export/sponsorTimes.db; fi