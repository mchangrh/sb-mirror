#!/bin/sh
echo "Uses SponsorBlock data from https://sponsor.ajay.app/"
sh /download.sh
if [ -n "$MIRROR" ]; then                                                                         # if mirror is enabled, start mirroring
	echo "*/5 * * * * /usr/bin/flock -n /tmp/download.lockfile sh /download.sh" >>/etc/crontabs/root # update every 5 minutes
	echo "Starting rsync daemon"
	rsync --daemon
	crond -f
fi

