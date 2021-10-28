#!/bin/sh
# download licence
echo "Uses SponsorBlock data from https://sponsor.ajay.app/"

sh /download.sh # download latest

if [ ! -z $MIRROR ] # if mirror is enabled, start mirroring
then
  echo "*/5 * * * * root sh /download.sh" >> /etc/crontab # set up crontab for updates every 5 minutes
  echo "Starting rsync daemon"
  rsync --daemon
  cron -f
fi