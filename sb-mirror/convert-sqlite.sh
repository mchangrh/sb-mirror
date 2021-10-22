#!/bin/sh
rm -f -- /export/SponsorTimesDB.db
for file in /mirror/*.csv
do
    sqlite3 -separator ',' /export/SponsorTimesDB.db ".import $file ${file%.*}" 
done