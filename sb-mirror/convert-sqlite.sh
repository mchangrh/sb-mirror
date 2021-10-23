#!/bin/sh
rm -f -- /export/SponsorTimes.db
wget http://sb-archive.mchang.xyz/sb-mirror/sponsorTimes.db -O /export/SponsorTimesDB.db

for file in /export/*.csv
do
  filename=`basename $file .csv`
  sqlite3 -separator ',' /export/SponsorTimesDB.db ".import --skip 1 $file ${filename}" 
done