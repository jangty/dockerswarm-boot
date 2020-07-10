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

sed "s/%DEPLOY_MODE%/${DEPLOY_MODE}/g" -i ${dir}/docker/entrypoint.sh


# scouter conf
sed "s/%NET_COLLECTOR_IP%/${SCOUTER_COLLECTOR_IP}/g" -i ${dir}/docker/scouter/scouter.conf
sed "s/%NET_COLLECTOR_UDP_PORT%/${SCOUTER_UDP_PORT}/g" -i ${dir}/docker/scouter/scouter.conf
sed "s/%NET_COLLECTOR_TCP_PORT%/${SCOUTER_TCP_PORT}/g" -i ${dir}/docker/scouter/scouter.conf


## image build
docker build -t ${REGISTRY}/${APPLICATION_NAME} -f docker/Dockerfile .
docker tag ${REGISTRY}/${APPLICATION_NAME}:latest ${REGISTRY}/${APPLICATION_NAME}:latest

# login to image registry
docker login -u jenkins -p jenkins ${REGISTRY}

# image push
docker push ${REGISTRY}/${APPLICATION_NAME}



