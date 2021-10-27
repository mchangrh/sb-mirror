## docker-compose syntax
```yml
  rsync:
    container_name: rsync
    image: mchangrh/rsync
    restart: always
    ports:
      - 873:873
    volumes:
      - ./rsync.conf:/etc/rsync.conf
      - ./mirror:/mirror
```