# https://spring.io/guides/gs/spring-boot-docker/

FROM openjdk:8

#RUN adduser asmanager

#USER asmanager

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
ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Dmaven.test.skip=true", "-jar", "app.jar"]


# TODO : log dir
