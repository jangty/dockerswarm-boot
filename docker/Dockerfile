# https://spring.io/guides/gs/spring-boot-docker/

FROM openjdk:8

#RUN adduser asmanager

#USER asmanager

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} app.jar


# scouter
RUN mkdir scouter
COPY docker/scouter scouter

EXPOSE 8080

#ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Dmaven.test.skip=true", "-Dserver.port=8080", "-jar", "app.jar"]
ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Dmaven.test.skip=true", "-jar", "app.jar"]


# TODO : log dir
