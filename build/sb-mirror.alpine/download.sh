#!/bin/sh
URL=${MIRROR_URL:-"sponsor.ajay.app"} # download from main mirror if none specified
MIRROR_DIR=${MIRROR_DIR:-"/mirror"}
curl -sL https://raw.githubusercontent.com/wiki/ajayyy/SponsorBlock/Database-and-API-License.md -o ${MIRROR_DIR}/licence.md
mkdir ${MIRROR_DIR}/

echo "Downloading from $URL"
if [ -n "$MIRROR_URL" ]; then rsync -rztvP --zc=lz4 --append rsync://$URL/sponsorblock ${MIRROR_DIR}
else
  # download from main server so get filenames
  curl -sL $URL/database.json?generate=false -o response.json
  DUMP_DATE=$(jq .lastUpdated < response.json)
  set -- $(jq -r .links[].table < response.json)
  rm response.json

  # set $@ since posix doesn't have named variables
  for table in "$@"; do rsync -ztvP --zc=lz4 --append rsync://$URL/sponsorblock/${table}_${DUMP_DATE}.csv ${MIRROR_DIR}/${table}.csv; done
  date -d@$(echo $DUMP_DATE | cut -c 1-10) +%F_%H-%M > ${MIRROR_DIR}/lastUpdate.txt
fi

# if sqlite, merge all csvs into one .db file
if [ -n "$SQLITE" ]; then sh /convert-sqlite.sh; fi