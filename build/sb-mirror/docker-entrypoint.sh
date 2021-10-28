#!/bin/sh
# download licence
curl -s https://raw.githubusercontent.com/wiki/ajayyy/SponsorBlock/Database-and-API-License.md -o /mirror/licence.md
echo "Uses SponsorBlock data from https://sponsor.ajay.app/"

sh /download.sh # download latest

if [ ! -z $MIRROR ] # if mirror is enabled, start mirroring
then
  echo "*/5 * * * * root sh /download.sh" >> /etc/crontab # set up crontab for updates every 5 minutes
  # path for alpine is /etc/crontabs/root
  echo "Starting rsync daemon"
  rsync --daemon
  # alpine crond -l 2 -f
  cron -f
fi