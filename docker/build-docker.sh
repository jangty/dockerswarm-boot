#!/bin/bash
dir=`pwd`
source ${dir}/docker/.env

sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/entrypoint.sh
sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/Dockerfile
sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/docker-stack.yml

sed "s/%HTTP_PORT%/${HTTP_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%AJP_PORT%/${AJP_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%ADMIN_PORT%/${ADMIN_PORT}/g" -i ${dir}/docker/docker-stack.yml


## image build
docker build -t ${REGISTRY}/${APPLICATION_NAME}  .
docker tag ${REGISTRY}/${APPLICATION_NAME}:latest ${REGISTRY}/${APPLICATION_NAME}:latest
docker push ${REGISTRY}/${APPLICATION_NAME}



