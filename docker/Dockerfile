# https://spring.io/guides/gs/spring-boot-docker/

FROM centos:7.8.2003

#RUN yum -y install openjdk:8 && \
#    yum clean all
RUN yum install -y java-1.8.0-openjdk  \
    java-1.8.0-openjdk-devel  \
    net-tools \
    locales

#RUN adduser asmanager

#USER asmanager

ARG JAR_FILE=site/target/*.war

COPY ${JAR_FILE} app.war

RUN groupadd -r docker \
    && useradd -r -g docker asmanager

# scouter
RUN mkdir scouter
COPY docker/scouter scouter
RUN chmod -R 777 scouter && chown -R asmanager scouter

RUN mkdir scripts
COPY docker/entrypoint.sh scripts
RUN chmod -R 777 scripts && chown -R asmanager scripts

#RUN mkdir box
#RUN mkdir box/java_logs
#RUN mkdir box/java_logs/%APPLICATION_NAME%


EXPOSE 8080

USER asmanager

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

CMD scripts/entrypoint.sh
#ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Dmaven.test.skip=true", "-Xms128m", "-Xmx1024m", "-javaagent:scouter/scouter.agent.jar", "-Dscouter.config=scouter/scouter.conf", "-jar", "app.jar"]


# TODO : log dir
