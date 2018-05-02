FROM openjdk:8

# Install Docker
RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce

# Install Rundeck
ENV RDECK_VERSION=2.11.0 \
    RDECK_BASE=/opt/rundeck

RUN curl -o /usr/local/src/rundeck-launcher-${RDECK_VERSION}.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-${RDECK_VERSION}.jar && \
    java -jar /usr/local/src/rundeck-launcher-${RDECK_VERSION}.jar --installonly -b ${RDECK_BASE}

ENV RDECK_URL=http:\\/\\/localhost:4440 \
    RDECK_ADMIN_USER=admin \
    RDECK_ADMIN_PASS=pass

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Setting Container
VOLUME ["/opt/rundeck/projects/", "/opt/rundeck/server/data/", "/opt/rundeck/var/logs/"]

EXPOSE 4440

CMD ["/opt/entrypoint.sh"]
