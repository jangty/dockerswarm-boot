#!/bin/bash
dir=`pwd`
source ${dir}/docker/.env


## image build
docker build -t ${REGISTRY}/${APPLICATION_NAME} -f docker/Dockerfile .
docker tag ${REGISTRY}/${APPLICATION_NAME}:latest ${REGISTRY}/${APPLICATION_NAME}:latest

# login to image registry
docker login -u jenkins -p jenkins ${REGISTRY}

# image push
docker push ${REGISTRY}/${APPLICATION_NAME}



