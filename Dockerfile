FROM rundeck/rundeck:4.12.1
LABEL maintainer="u6k.apps@gmail.com"

# Setup timezone
RUN sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y --no-install-recommends tzdata
ENV TZ=Asia/Tokyo

# Install Rundeck plugin
RUN curl -L -o /home/rundeck/libext/slack-incoming-webhook-plugin.jar https://github.com/rundeck-plugins/slack-incoming-webhook-plugin/releases/download/v1.2.5/slack-incoming-webhook-plugin-1.2.5.jar

# Install softwares
RUN sudo apt-get install -y --no-install-recommends awscli p7zip-full build-essential mariadb-client && \
    sudo apt-get clean

# Setup postgresql 12
RUN sudo apt-get install -y --no-install-recommends lsb-release curl ca-certificates gnupg && \
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && \
    sudo apt-get install -y --no-install-recommends postgresql-client-12 && \
    sudo apt-get clean

# Install Python3
RUN sudo apt-get install -y --no-install-recommends software-properties-common && \
    sudo add-apt-repository ppa:deadsnakes/ppa && \
    sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends python3 python3-pip && \
    sudo apt-get clean

# Install Docker
RUN sudo apt-get install -y --no-install-recommends ca-certificates curl gnupg && \
    sudo install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    sudo chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends docker-ce-cli && \
    echo rundeck ALL=NOPASSWD: /usr/bin/docker | sudo tee -a /etc/sudoers

