# SponsorBlock Mirror
Docker containers to mirror the [SponsorBlock](https://sponsor.ajay.app) database + API

This work is dual-licenced under GPL-3.0-only AND MIT

---
## SponsorBlock Database Licence
SponsorBlock data and databases are under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) from https://sponsor.ajay.app.

---

## Usage
This copies the latest SponsorBlock database to the `./sb-mirror` local directory

```sh
docker run --rm -it -v "${PWD}/sb-mirror:/mirror" mchangrh/sb-mirror:latest
```
docker-compose
```yml
sb-mirror:
  image: mchangrh/sb-mirror:latest
  build: ./build/sb-mirror
  # map port externally
  ports:
    - "873:873"
  environment:
    # - MIRROR=TRUE # enable cronjob
    # - MIRROR_URL=qc.mchang.xyz # override to set upstream mirror, defaults to sponsor.ajay.app
    # - SQLITE=FALSE # generate .db in /export
  volumes:
    - ./mirror:/mirror
    - ./export:/export
```
---
## Mirroring

If you would like to set up an active mirror, allow `873/tcp` through your firewalls for rsyncd and uncomment lines in docker-compose

If you would like to set up a full API mirror, see [containers](./docs/containers.md)

---

Contributions & Pull request are always welcome & appreciated

non-exhaustive list of packages & respective licences [here](./LICENSES.md)

There is an active rsync mirror that only downloads once every 24 hours and can be found [here](https://github.com/mchangrh/sb-archive)