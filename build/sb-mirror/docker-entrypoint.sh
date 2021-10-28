#!/bin/sh
echo "Uses SponsorBlock data from https://sponsor.ajay.app/"
sh /download.sh
if [ -n "$MIRROR" ]; then # if mirror is enabled, start mirroring
  echo "*/5 * * * * root sh /download.sh" >> /etc/crontab # set up crontab for updates every 5 minutes
  echo "Starting rsync daemon"
  rsync --daemon
  cron -f
fi