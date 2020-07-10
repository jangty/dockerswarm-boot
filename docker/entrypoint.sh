# scouter host name
obj_host_name=%APPLICATION_NAME%

HOSTNAME=`hostname`
DATE=$(date +%Y%m%d%H%M%S)
obj_name=${obj_host_name}_${DATE}_${HOSTNAME}

sed "s/%OBJ_NAME%/${obj_name}/g" -i scouter/scouter.conf
sed "s/%OBJ_HOST_NAME%/${obj_host_name}/g" -i scouter/scouter.conf

java -Dspring.profiles.active=prod -Dmaven.test.skip=true -Xms128m -Xmx1024m -javaagent:scouter/scouter.agent.jar -Dscouter.config=scouter/scouter.conf -jar app.war
#bin/startup.sh; tail -f logs/catalina.out