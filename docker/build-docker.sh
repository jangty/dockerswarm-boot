#!/bin/bash

source .env

docker build -t ${REGISTRY}/${APPLICATION_NAME}  .
docker tag ${REGISTRY}/${APPLICATION_NAME}:latest ${REGISTRY}/${APPLICATION_NAME}:latest
docker push ${REGISTRY}/${APPLICATION_NAME}

sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i scripts/entrypoint.sh