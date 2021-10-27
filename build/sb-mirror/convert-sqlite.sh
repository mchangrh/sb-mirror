#!/bin/sh
rm -f -- /export/SponsorTimes.db
curl -s -L https://sponsor.ajay.app/download/sponsorTimes.db -o /export/SponsorTimesDB.db

for file in /export/*.csv
do
  filename=`basename $file .csv`
  sqlite3 -separator ',' /export/SponsorTimesDB.db ".import --skip 1 $file ${filename}" 
done