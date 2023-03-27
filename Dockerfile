
FROM alpine

RUN apk update && \
    apk add inotify-tools bash
VOLUME /watch
