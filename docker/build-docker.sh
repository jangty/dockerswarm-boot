#!/bin/bash
dir=`pwd`
source ${dir}/docker/.env

sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/entrypoint.sh
sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/Dockerfile
sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/docker-stack.yml

sed "s/%HTTP_PORT%/${HTTP_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%AJP_PORT%/${AJP_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%ADMIN_PORT%/${ADMIN_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%REGISTRY%/${REGISTRY}/g" -i ${dir}/docker/docker-stack.yml

sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/stack_deploy_jenkins.sh
sed "s/%REGISTRY%/${REGISTRY}/g" -i ${dir}/stack_deploy_jenkins.sh

sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/rollback_jenkins.sh

## image build
docker build -t ${REGISTRY}/${APPLICATION_NAME} -f docker/Dockerfile .
docker tag ${REGISTRY}/${APPLICATION_NAME}:latest ${REGISTRY}/${APPLICATION_NAME}:latest

# login to image registry
docker login -u jenkins -p jenkins ${REGISTRY}

# image push
docker push ${REGISTRY}/${APPLICATION_NAME}



