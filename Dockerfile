FROM rundeck/rundeck:3.4.3
LABEL maintainer="u6k.apps@gmail.com"

# Setup timezone
RUN sudo apt-get update && \
    sudo apt-get install -y tzdata
ENV TZ=Asia/Tokyo

# Setup postgresql 12 repository
RUN sudo apt-get update && \
    sudo apt-get install -y lsb-release curl ca-certificates gnupg && \
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && \
    sudo apt-get clean

# Install softwares
RUN sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y postgresql-client-12 awscli p7zip-full build-essential python3 python3-pip mariadb-client && \
    sudo apt-get clean && \
    pip3 install --upgrade pip requests

# Install Docker
RUN sudo apt-get update && \
    sudo apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    sudo apt-get update && \
    sudo apt-get -y install docker-ce-cli && \
    echo rundeck ALL=NOPASSWD: /usr/bin/docker | sudo tee -a /etc/sudoers

# Install Rundeck plugin
RUN curl -L -o /home/rundeck/libext/slack-incoming-webhook-plugin.jar https://github.com/rundeck-plugins/slack-incoming-webhook-plugin/releases/download/v1.2.5/slack-incoming-webhook-plugin-1.2.5.jar
