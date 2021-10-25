#!/bin/sh
sh /download.sh # download latest

if [[ $MIRROR ]]; # if mirror is enabled, start mirroring
then
  echo "*/5 * * * * /download.sh" > /etc/crontabs/root # set up crontab for updates every 5 minutes
  echo "Starting rsync daemon"
  rsync --daemon
  crond -l 2 -f
fi