# https://spring.io/guides/gs/spring-boot-docker/

FROM centos:7.8.2003

RUN yum -y install openjdk:8 && \
    yum clean all

#RUN adduser asmanager

#USER asmanager

HOSTNAME=appname

ARG JAR_FILE=site/target/*.jar

COPY ${JAR_FILE} app.jar


# scouter
RUN mkdir scouter
COPY docker/scouter scouter

RUN mkdir box
RUN mkdir box/java_logs
RUN mkdir box/java_logs/vms


EXPOSE 8080

#ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Dmaven.test.skip=true", "-Dserver.port=8080", "-jar", "app.jar"]
ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Dmaven.test.skip=true", "-Xms128m", "-Xmx1024m", "-javaagent:scouter/scouter.agent.jar", "-Dscouter.config=scouter/scouter.conf", "-jar", "app.jar"]


# TODO : log dir
