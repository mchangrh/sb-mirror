#!/bin/sh
MIRROR_DIR=${MIRROR_DIR:-"/mirror"}
EXPORT_DIR=${EXPORT_DIR:-"/export"}

mkdir ${EXPORT_DIR}/
rm -f -- ${EXPORT_DIR}/SponsorTimes.db
curl -s -L https://sponsor.ajay.app/download/sponsorTimes.db -o ${EXPORT_DIR}/SponsorTimesDB.db

for file in ${MIRROR_DIR}/*.csv
do
  filename=`basename $file .csv`
  sqlite3 -separator ',' ${EXPORT_DIR}/SponsorTimesDB.db ".import --skip 1 $file ${filename}" 
done