#!/bin/sh
URL=${MIRROR_URL:-"sponsor.ajay.app"} # download from main mirror if none specified
MIRROR_DIR=${MIRROR_DIR:-"/mirror"}
curl -s https://raw.githubusercontent.com/wiki/ajayyy/SponsorBlock/Database-and-API-License.md -o ${MIRROR_DIR}/licence.md

download() {
  curl -sL https://git.io/sb-dbapi-license -o ${MIRROR_DIR}/licence.md
  echo "Downloading from $URL"
  EXTRAPARAM=$1
  if [ -n "$MIRROR_URL" ]; then rsync -rztvP --zc=lz4 "$1" --append rsync://$URL/sponsorblock ${MIRROR_DIR}
  else
    # download from main server so get filenames
    curl -sL $URL/database.json?generate=false -o response.json
    DUMP_DATE=$(jq .lastUpdated < response.json)
    # set $@ since posix doesn't have named variables
    set -- $(jq -r .links[].table < response.json)
    rm response.json

    for table in "$@"
    do rsync -ztvP --zc=lz4 "$1" --append rsync://$URL/sponsorblock/${table}_${DUMP_DATE}.csv ${MIRROR_DIR}/${table}.csv; done
    date -d@$(echo $DUMP_DATE | cut -c 1-10) +%F_%H-%M > ${MIRROR_DIR}/lastUpdate.txt
  fi
}

validate() {
  echo "Validating Downloads"
  FAIL=0
  for file in ${MIRROR_DIR}/*.csv
    if ! csvlint "$file"; then
      rm "$file"
      FAIL=1
    fi
  done
  echo $FAIL
  if [ $FAIL -eq 1 ]; then
    FAIL=0
    echo "Downloading failed files"
    download --ignore-existing
  fi
}

convert_sqlite() {
  echo "Starting SQLite Conversion"
  rm -f -- ${EXPORT_DIR}/SponsorTimes.db
  curl -sL https://sponsor.ajay.app/download/sponsorTimes.db -o ${EXPORT_DIR}/SponsorTimesDB.db

  for file in ${MIRROR_DIR}/*.csv; do
    filename=$(basename $file .csv)
    sqlite3 -separator ',' ${EXPORT_DIR}/SponsorTimesDB.db ".import --skip 1 $file ${filename}" 
  done
  unix_time=$(echo $DUMP_DATE | cut -c 1-10)
  echo $(date -d@$unix_time +%F_%H-%M) > ${MIRROR_DIR}/lastUpdate.txt
fi

if [ ! -z $SQLITE ] # if sqlite, merge all csvs into one .db file
then
  sh /convert-sqlite.sh
fi