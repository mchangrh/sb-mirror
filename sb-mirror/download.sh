#!/bin/sh
URL=${MIRROR_URL:-"sponsor.ajay.app"} # download from main mirror if none specified
# --zc=lz4 disable lz4 for now, pending aports merge
rsync -rztvP --append rsync://$URL/sponsorblock /mirror

if [[ $SQLITE ]]; # if sqlite, merge all csvs into one .db file
sh /convert-sqlite.sh