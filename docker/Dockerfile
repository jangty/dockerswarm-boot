# https://spring.io/guides/gs/spring-boot-docker/

FROM centos:7.8.2003

#RUN yum -y install openjdk:8 && \
#    yum clean all
RUN yum install -y java-1.8.0-openjdk  \
    java-1.8.0-openjdk-devel  \
    net-tools 

#RUN adduser asmanager

#USER asmanager
USER "701"

ARG JAR_FILE=site/target/*.jar

COPY ${JAR_FILE} app.jar


# scouter
RUN mkdir scouter
COPY docker/scouter scouter
RUN mkdir scripts
COPY docker/entrypoint.sh scripts
RUN chmod -R 777 scripts/entrypoint.sh

RUN mkdir box
RUN mkdir box/java_logs
RUN mkdir box/java_logs/vms


EXPOSE 8080

CMD scripts/entrypoint.sh
#ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Dmaven.test.skip=true", "-Xms128m", "-Xmx1024m", "-javaagent:scouter/scouter.agent.jar", "-Dscouter.config=scouter/scouter.conf", "-jar", "app.jar"]


# TODO : log dir
