#!/bin/sh

if [ "$1" = "" ] 
then
    echo "========== Usage ==================================================="
    echo " WARN : param 1 need"
    echo " param1 : docker update time interval"
    echo " ex) stack_deploy.sh param1"
    echo " ex) stack_deploy.sh 60s"
    echo "====================================================================="

    exit 1
fi

STACK_IS_RUNNING=`docker stack ls | grep "%STACK_NAME%" | wc -l`

if [ $STACK_IS_RUNNING = 0 ]
then
    echo "[INFO] docker stack %STACK_NAME% is not running. init start"
    docker stack deploy -c docker/docker-stack.yml --with-registry-auth %STACK_NAME%
fi

if [ $STACK_IS_RUNNING != 0 ]
then
    SERVICE_IS_RUNNING=`docker service ls | grep " %APPLICATION_NAME% " | wc -l`
    if [ $SERVICE_IS_RUNNING = 0 ]
    then
        echo "[INFO] docker SERVICE %APPLICATION_NAME% is not running. init start"
        docker stack deploy -c docker/docker-stack.yml --with-registry-auth %STACK_NAME%
    else
        echo "[INFO] docker stack is already running.. service update"
        echo "[INFO] docker service update --force --update-parallelism 1 --update-delay $1 --update-order=start-first --update-monitor=1s --update-max-failure-ratio=0 --update-failure-action rollback --image=%REGISTRY%/%APPLICATION_NAME%:latest %APPLICATION_NAME%"
        docker service update --force --update-parallelism 1 --update-delay $1 --with-registry-auth	--image=%REGISTRY%/%APPLICATION_NAME%:latest %APPLICATION_NAME%
    fi
fi

#docker service logs --tail 0 -f %APPLICATION_NAME%

SLEEP_CNT=0
while :
do
    echo "[INFO] WAITING... for start docker service"
    SLEEP_CNT=`expr $SLEEP_CNT + 1`
    SERVICE_IS_RUNNING=`docker service ls | grep "%APPLICATION_NAME%" | wc -l`
    echo "[INFO] SLEEP_CNT : "$SLEEP_CNT
    if [ $SERVICE_IS_RUNNING = 1 ] || [ $SLEEP_CNT = 5 ]
    then
        break
    fi
    
    sleep 1
done

docker service logs --tail 0 -f %APPLICATION_NAME% | while read line; do
    echo "$line"
      if [[ $line =~ 'Started SiteApplication in' ]]; then
            pkill -9 -P $$ -f "docker service logs --tail 0 -f"
      fi
      if [[ $line =~ 'Application run failed' ]]; then
            pkill -9 -P $$ -f "docker service logs --tail 0 -f"
            
            echo "[[[[[[[[[[[[ ERROR]]]]]]]]]]]] AUTO ROLLBACK !!!!!! "
            docker service rollback %APPLICATION_NAME%
            echo "[[[[[[[[[[[[ ERROR]]]]]]]]]]]] rollback Complete ! "
            echo "[INFO] CHECK Application Service !!!!!! "
            
            exit 1;
      fi
done
