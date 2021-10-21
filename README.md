# SponsorBlock Mirror

Docker container to mirror the SponsorBlock database over rsync

## Host a running mirror
`docker-compose up -d`

## Just download the database to ./sb-mirror
```sh
docker pull mchangrh/sb-mirror:latest
docker run --rm -it -v ./sb-mirror:/mirror mchangrh/sb-mirror:latest
```

### Environment Variables
MIRROR_URL: override to set upstream mirror, must be rsync  
MIRROR: set to start rsyncd and cron to run every 5 minutes