#!/bin/sh
rm -f -- /export/SponsorTimes.db
for file in /mirror/*.csv
do
  filename=`basename $file .csv`
  sqlite3 -separator ',' /export/SponsorTimesDB.db ".import $file ${filename}" 
done