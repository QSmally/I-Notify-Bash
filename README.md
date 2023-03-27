
# I-Notify-Bash

Image to run Bash scripts on filesystem events.

A minimal Alpine image with `inotify-tools` and `bash` installed.

## Usage

A compose file may look something like the following, running it with `$ docker compose up`.

```yml
watch:
  restart: always
  image: QSmally/I-Notify-Bash
  container_name: watch
  volumes:
    - "./tools:/tools:rw" # Injected files, e.g. a script
    - "./watch:/watch:ro" # A mounted directory to watch for inode changes
  entrypoint: /bin/bash -c 'while inotifywait /watch -e create,delete; do echo "..." done'
```
