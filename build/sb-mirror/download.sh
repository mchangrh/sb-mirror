#!/bin/sh
URL=${MIRROR_URL:-"sponsor.ajay.app"} # download from main mirror if none specified

# get filenames
curl $URL/database.json -o response.json
DUMP_DATE=$(cat response.json | jq .lastUpdated)
set -- $(cat response.json | jq -r .links[].table)

# set $@ since posix doesn't have named variables
for table in "$@"
do
# --zc=lz4 disable lz4 for now, pending aports merge
  rsync -rztvP --zc=lz4 --append rsync://$URL/sponsorblock/${table}_${DUMP_DATE}.csv ./mirror/${table}.csv
done

if [[ $SQLITE ]]; # if sqlite, merge all csvs into one .db file
sh /convert-sqlite.sh