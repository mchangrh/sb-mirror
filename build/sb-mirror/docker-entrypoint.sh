#!/bin/sh
sh /download.sh # download latest

if [ -z "$MIRROR" ] # if mirror is enabled, start mirroring
then
  echo "*/5 * * * * sh /download.sh" >> /var/spool/cron/crontabs/root # set up crontab for updates every 5 minutes
  # path for alpine is /etc/crontabs/root
  echo "Starting rsync daemon"
  rsync --daemon
  # alpine crond -l 2 -f
  cron -f -L 2
fi