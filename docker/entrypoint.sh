
# scouter host name
obj_host_name=appname-test

HOSTNAME=`hostname`
DATE=$(date +%Y%m%d%H%M%S)
obj_name=${obj_host_name}_${DATE}_${HOSTNAME}

# Scouter Server IP Address
net_collector_ip=10.50.106.137

# Update Scouter Ports
# UDP Receive Port(Default : 6100)
net_collector_udp_port=6040

# TCP Receive Port(Default : 6100)
net_collector_tcp_port=6040

#hook_method_patterns=${HOOK_METHOD_PATTERNS:-org.mybatis.jpetstore.*.*}

sed "s/%OBJ_NAME%/${obj_name}/g" -i scouter/conf/scouter.conf
sed "s/%OBJ_HOST_NAME%/${obj_host_name}/g" -i scouter/conf/scouter.conf
sed "s/%NET_COLLECTOR_IP%/${net_collector_ip}/g" -i scouter/conf/scouter.conf
sed "s/%NET_COLLECTOR_UDP_PORT%/${net_collector_udp_port}/g" -i scouter/conf/scouter.conf
sed "s/%NET_COLLECTOR_TCP_PORT%/${net_collector_tcp_port}/g" -i scouter/conf/scouter.conf
#sed "s/%HOOK_METHOD_PATTERNS%/${hook_method_patterns}/g" -i scouter/conf/scouter.conf


java -Dspring.profiles.active=dev -Dmaven.test.skip=true -Xms128m -Xmx1024m -javaagent:scouter/scouter.agent.jar -Dscouter.config=scouter/scouter.conf -jar app.jar
#bin/startup.sh; tail -f logs/catalina.out