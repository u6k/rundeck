FROM openjdk:8

RUN curl -o /usr/local/src/rundeck-launcher.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-2.11.0.jar

EXPOSE 4440

CMD ["java", "-Dserver.hostname=localhost", "-jar", "/usr/local/src/rundeck-launcher.jar"]
