#!/bin/sh
URL=${MIRROR_URL:-"sponsor.ajay.app"} # download from main mirror if none specified
MIRROR_DIR=${MIRROR_DIR:-"/mirror"}
EXPORT_DIR=${EXPORT_DIR:-"/export"}
mkdir -p ${MIRROR_DIR}/ ${EXPORT_DIR}/

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
}

download
# validate unless NO_VALIDATE
if [ -z "$NO_VALIDATE" ]; then validate; fi
# if sqlite, merge all csvs into one .db file
if [ -n "$SQLITE" ]; then convert_sqlite; fi