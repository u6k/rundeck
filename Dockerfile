FROM openjdk:8

# Install Rundeck
ENV RDECK_VERSION=2.11.0

RUN curl -o /usr/local/src/rundeck-launcher-${RDECK_VERSION}.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-${RDECK_VERSION}.jar

ENV RDECK_BASE=/opt/rundeck \
    RDECK_HOSTNAME=localhost

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

VOLUME ["/opt/rundeck/etc/", "/opt/rundeck/projects/", "/opt/rundeck/server/config/", "/opt/rundeck/server/data/", "/opt/rundeck/var/logs/"

# Install Docker
RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce

# Setting Container
EXPOSE 4440

ENTRYPOINT ["/opt/entrypoint.sh"]
