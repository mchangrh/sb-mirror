# Running the server
1. Set up the SponsorBlock Server
The instructions for setting up the Sponsorblock Server will not be reiterated in this doc and can be found at https://github.com/ajayyy/SponsorBlockServer.

1. Setting up with docker
    1. Start the postgres database and mirror with `docker-compose up`
2. Setting up manually
    1. Download the mirror to a known directory
    2. Set `postgresExportPath` to the mirror directory
    3. Set the postgres parameters in `server-runner/config.json` to match
3. Move `server-runner/config.json` to the root of the SponsorBlockServer

## Known Issues
- the only database that currently works is `postgres`
- SQLite is not supported since the update schemas conflict with the created database
- MSSQL can be added with `LOAD DATA` instead of `COPY`
- currently there is no way to live reload data without loading all the files again

# Server Details
The admin ID is a hash of `WjGS5C9WRhVzjmB8KdrdR8jLqvTwC5q5kAGdC5WVzfDcbAPX`