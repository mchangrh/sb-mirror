#!/bin/sh
MIRROR_DIR=${MIRROR_DIR:-"/mirror"}
EXPORT_DIR=${EXPORT_DIR:-"/export"}
mkdir -p "${MIRROR_DIR}"/ "${EXPORT_DIR}"/

RSYNC_ARGS="-ztvP --no-W --inplace --zc=lz4 --contimeout=10"

download() {
  curl -sL https://raw.githubusercontent.com/wiki/ajayyy/SponsorBlock/Database-and-API-License.md -o "$MIRROR_DIR"/licence.md
  if [ -n "$MIRROR_URL" ]; then
    echo "Downloading from mirror: $MIRROR_URL"
    rsync ${RSYNC_ARGS} -r --exclude='*.txt' rsync://"$MIRROR_URL"/sponsorblock "${MIRROR_DIR}"
  else
    echo "Downloading from main mirror"
    # get filenames
    curl -sL https://sponsor.ajay.app/database.json?generate=false -o response.json
    DUMP_DATE=$(jq .lastUpdated < response.json)
    # set $@ since posix doesn't have named variables
    set -- $(jq -r .links[].table < response.json)
    rm response.json

    for table in "$@"
    do
      echo "Downloading $table.csv"
      rsync ${RSYNC_ARGS} rsync://rsync.sponsor.ajay.app:31111/sponsorblock/"${table}"_"${DUMP_DATE}".csv "${MIRROR_DIR}"/"${table}".csv ||
        curl --compressed -L https://sponsor.ajay.app/database/"${table}".csv?generate=false -o "${MIRROR_DIR}"/"${table}".csv
      # fallback to curl
      if [ -z "$VALIDATE" ]; then # re-run rsync if validate
        rsync ${RSYNC_ARGS} rsync://rsync.sponsor.ajay.app:31111/sponsorblock/"${table}"_"${DUMP_DATE}".csv "${MIRROR_DIR}"/"${table}".csv
      fi
    done
    date -d@"$(echo "$DUMP_DATE" | cut -c 1-10)" +%F_%H-%M > "${MIRROR_DIR}"/lastUpdate.txt
  fi
}

lint_file() {
  FILENAME=$1
  COLS=$(head -n1 "$FILENAME" | awk 'BEGIN{FS=","}END{print NF}')
  awk -F, -v COLS="$COLS" '{OFS=FS} NF=COLS {print}' "$FILENAME" > tmp.csv && mv tmp.csv "$FILENAME"
}

csvlint() {
  echo "Validating Downloads"
  for file in "${MIRROR_DIR}"/*.csv
  do lint_file "$file"; done
}

convert_sqlite() {
  echo "Starting SQLite Conversion"
  rm -f -- "${EXPORT_DIR}"/SponsorTimes.db
  curl -sL https://b2.ajay.app/file/sponsorblock-gh-public/sponsorTimes.db -o "${EXPORT_DIR}"/SponsorTimesDB.db
  
  # only convert sponsorTimes for now
  sqlite3 -separator ',' "${EXPORT_DIR}"/SponsorTimesDB.db ".import --skip 1 ${MIRROR_DIR}/sponsorTimes.csv sponsorTimes"
  # sqlite setup
  # for file in "${MIRROR_DIR}"/*.csv; do
  #   filename=$(basename "$file" .csv)
  #   echo "$filename"
  #   sqlite3 -separator ',' "${EXPORT_DIR}"/SponsorTimesDB.db ".import --skip 1 $file ${filename}"
  # done
  sqlite3 "${EXPORT_DIR}"/SponsorTimesDB.db "VACUUM;"
}

# trap exits
trap 'exit 2' 2

download
# if csvlint, lint csv files
if [ -n "$CSVLINT" ]; then csvlint; fi
# if SQLITE, merge all csvs into one .db file
if [ -n "$SQLITE" ]; then convert_sqlite; fi