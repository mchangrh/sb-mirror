#!/bin/sh
URL=${MIRROR_URL:-"sponsor.ajay.app"} # download from main mirror if none specified
mkdir /mirror

echo "Downloading from $URL"
if [ ! -z $URL ]
then
  rsync -rztvP --zc=lz4 --append rsync://$URL/sponsorblock /mirror
else
  # download from main server so get filenames
  curl -L $URL/database.json?generate=false -o response.json
  DUMP_DATE=$(cat response.json | jq .lastUpdated)
  set -- $(cat response.json | jq -r .links[].table)

  # set $@ since posix doesn't have named variables
  for table in "$@"
  do
  # --zc=lz4 disable lz4 for now, pending aports merge
    rsync -ztvP --zc=lz4 --append rsync://$URL/sponsorblock/${table}_${DUMP_DATE}.csv /mirror/${table}.csv
  done
fi

if [ -z $SQLITE ] # if sqlite, merge all csvs into one .db file
then
  sh /convert-sqlite.sh
fi