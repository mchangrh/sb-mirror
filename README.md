# SponsorBlock Mirror

Docker container to mirror the SponsorBlock database over rsync
## Just download locally
`docker run --rm -it -v "${PWD}/sb-mirror:/mirror" mchangrh/sb-mirror:latest`

# sb-mirror
Create an rsync mirror of the SponsorBlock database

## misc
The admin ID is a hash of `WjGS5C9WRhVzjmB8KdrdR8jLqvTwC5q5kAGdC5WVzfDcbAPX`

## Environment Variables
SQLITE: set to auto-generate sqlite .db file to /export  
MIRROR_URL: override to set upstream mirror, must be rsync  
MIRROR: set to start rsyncd and cron to run every 5 minutes

# sb-server-runner
Download and run the SponsorBlockServer from the master branch

## Environment Variables
DBINIT: only initialize the database and exit

# docker-compose
1. Postgres
    1. Download the mirror to a known directory
    2. Set `postgresExportPath` to the mirror directory
    3. Copy `config/postgres-config.json` to the config directory
2. SQLite
    1. Set `SQLITE=TRUE` on sb-mirror
    2. Set the export directories for `SponsorBlockDB.db`

# Databases
| Database 	| Postgres 	| SQLite 	| MSSQL 	|
|---	|---	|---	|---	|
| Advantages 	| Performs Well 	| Performs Poorly 	| - 	|
| Disadvantages 	| RAM intensive COPY on start 	| Starts Immediately 	| Not Supported 	|