#!/bin/sh
URL=${MIRROR_URL:-"sponsor.ajay.app"} # download from main mirror if none specified
MIRROR_DIR=${MIRROR_DIR:-"/mirror"}
curl -s https://raw.githubusercontent.com/wiki/ajayyy/SponsorBlock/Database-and-API-License.md -o ${MIRROR_DIR}/licence.md

echo "Downloading from $URL"
if [ ! -z $MIRROR_URL ]
then
  rsync -rztvP --zc=lz4 --append rsync://$URL/sponsorblock ${MIRROR_DIR}
else
  # download from main server so get filenames
  curl -s -L $URL/database.json?generate=false -o response.json
  DUMP_DATE=$(cat response.json | jq .lastUpdated)
  set -- $(cat response.json | jq -r .links[].table)
  rm response.json

  # set $@ since posix doesn't have named variables
  for table in "$@"
  do
    rsync -ztvP --zc=lz4 --append rsync://$URL/sponsorblock/${table}_${DUMP_DATE}.csv ${MIRROR_DIR}/${table}.csv
  done
  unix_time=$(echo $DUMP_DATE | cut -c 1-10)
  echo $(date -d@$unix_time +%F_%H-%M) > ${MIRROR_DIR}/lastUpdate.txt
fi

if [ ! -z $SQLITE ] # if sqlite, merge all csvs into one .db file
then
  sh /convert-sqlite.sh
fi