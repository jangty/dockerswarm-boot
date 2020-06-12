#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]  || [ "$4" = "" ]
then
    echo "========== Usage ==================================================="
    echo " WARN : param 4 need"
    echo " param1 : application name"
    echo " param2 : docker-stack.yml's service name"
    echo " param3 : docker image name"
    echo " param4 : docker update time interval"
    echo " ex) stack_deploy.sh param1 param2 param3 param4"
    echo " ex) stack_deploy.sh test-was springboot 10.50.23.30:5000/test-boot:latest 60s"
    echo "====================================================================="

    exit 1
fi

STACK_IS_RUNNING=`docker stack ls | grep "$1" | wc -l`

if [ $STACK_IS_RUNNING = 0 ]
then
    echo "[INFO] docker stack $1 is not running. init start"
    docker stack deploy -c docker/docker-stack.yml $1
fi

if [ $STACK_IS_RUNNING != 0 ]
then
    echo "[INFO] docker stack is already running.. service update"
    echo "[INFO] docker service update --force --update-parallelism 1 --update-delay $4 --update-order=start-first --update-monitor=1s --update-max-failure-ratio=0 --update-failure-action rollback --image=$3 $1_$2"
    docker service update --force --update-parallelism 1 --update-delay $4 --image=$3 $1_$2
fi

#docker service logs --tail 0 -f $1_$2

SLEEP_CNT=0
while :
do
    echo "[INFO] WAITING... for start docker service"
    SLEEP_CNT=`expr $SLEEP_CNT + 1`
    SERVICE_IS_RUNNING=`docker service ls | grep "$1_$2" | wc -l`
    echo "[INFO] SLEEP_CNT : "$SLEEP_CNT
    if [ $SERVICE_IS_RUNNING = 1 ] || [ $SLEEP_CNT = 5 ]
    then
        break
    fi
    
    sleep 1
done

docker service logs --tail 0 -f $1_$2 | while read line; do
    echo "$line"
      if [[ $line =~ 'Started SiteApplication in' ]]; then
            pkill -9 -P $$ -f "docker service logs --tail 0 -f"
      fi
      if [[ $line =~ 'Application run failed' ]]; then
            pkill -9 -P $$ -f "docker service logs --tail 0 -f"
            
            echo "[[[[[[[[[[[[ ERROR]]]]]]]]]]]] AUTO ROLLBACK !!!!!! "
            docker service rollback $1_$2
            echo "[[[[[[[[[[[[ ERROR]]]]]]]]]]]] rollback Complete ! "
            echo "[INFO] CHECK Application Service !!!!!! "
            
            exit 1;
      fi
done
