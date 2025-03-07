#!/bin/bash
docker run \
    --net=host \
    -e TZ=Havana/Cuba \
    -v $(pwd)/data:/data \
    --name "mailserver" \
    -h "mail.example.com" \
    -t analogic/poste.io
