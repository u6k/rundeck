FROM openjdk:8

ENV RDECK_VERSION=2.11.0

RUN curl -o /usr/local/src/rundeck-launcher-${RDECK_VERSION}.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-${RDECK_VERSION}.jar

EXPOSE 4440

CMD ["java", "-Dserver.hostname=localhost", "-jar", "/usr/local/src/rundeck-launcher.jar"]
