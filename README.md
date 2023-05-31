
# I-Notify-Bash

Image to run Bash scripts on filesystem events.

A minimal Alpine image with `inotify-tools` and `bash` installed.

## Usage

A compose file may look something like the following, running it with `$ docker compose up`.

```yml
watch:
  restart: always
  image: qsmally/i-notify-bash
  container_name: watch
  volumes:
    - "./tools:/tools:rw" # Injected files, e.g. a script
    - "./watch:/watch:ro" # A mounted directory to watch for inode changes
  entrypoint: /tools/watch.sh
```

`tools/watch.sh`:

```bash
#!/bin/bash

# Echo creation and deletion of files
inotifywait /watch -mq -e create -e delete --format='%f' |
    while read -r FILE; do echo $FILE; done

# Echo creation, deletion and modification of files with debounce
inotifywait /watch -e create -e delete -e modify -mq --format '%f' |
    while read -r FILE; do
        echo "Skipping $(timeout 1 cat | wc -l) further changes to debounce filesystem events"
        echo $FILE
    done
```
