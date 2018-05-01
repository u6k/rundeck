FROM openjdk:8

ENV RDECK_VERSION=2.11.0

RUN curl -o /usr/local/src/rundeck-launcher-${RDECK_VERSION}.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-${RDECK_VERSION}.jar

ENV RDECK_BASE=/opt/rundeck \
    RDECK_HOSTNAME=localhost

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

VOLUME ["/opt/rundeck/etc/", "/opt/rundeck/projects/", "/opt/rundeck/server/config/", "/opt/rundeck/server/data/", "/opt/rundeck/var/logs/"

EXPOSE 4440

ENTRYPOINT ["/opt/entrypoint.sh"]
