#!/bin/bash
dir=`pwd`
source ${dir}/docker/.env

sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/entrypoint.sh
sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/docker/docker-stack.yml

sed "s/%HTTP_PORT%/${HTTP_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%AJP_PORT%/${AJP_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%ADMIN_PORT%/${ADMIN_PORT}/g" -i ${dir}/docker/docker-stack.yml
sed "s/%REGISTRY%/${REGISTRY}/g" -i ${dir}/docker/docker-stack.yml

sed "s/%STACK_NAME%/${STACK_NAME}/g" -i ${dir}/stack_deploy_jenkins.sh
sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/stack_deploy_jenkins.sh
sed "s/%REGISTRY%/${REGISTRY}/g" -i ${dir}/stack_deploy_jenkins.sh

sed "s/%APPLICATION_NAME%/${APPLICATION_NAME}/g" -i ${dir}/rollback_jenkins.sh

sed "s/%DEPLOY_MODE%/${DEPLOY_MODE}/g" -i ${dir}/docker/entrypoint.sh


# scouter conf
sed "s/%NET_COLLECTOR_IP%/${SCOUTER_COLLECTOR_IP}/g" -i ${dir}/docker/scouter/scouter.conf
sed "s/%NET_COLLECTOR_UDP_PORT%/${SCOUTER_UDP_PORT}/g" -i ${dir}/docker/scouter/scouter.conf
sed "s/%NET_COLLECTOR_TCP_PORT%/${SCOUTER_TCP_PORT}/g" -i ${dir}/docker/scouter/scouter.conf





