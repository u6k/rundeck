FROM rundeck/rundeck:3.2.9
LABEL maintainer="u6k.apps@gmail.com"

# Install softwares
RUN sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y postgresql-client awscli p7zip-full build-essential python3 python3-pip && \
    sudo apt-get clean && \
    pip3 install --upgrade pip requests

# Install Rundeck plugin
RUN curl -L -o /home/rundeck/libext/slack-incoming-webhook-plugin.jar https://github.com/rundeck-plugins/slack-incoming-webhook-plugin/releases/download/v1.2.5/slack-incoming-webhook-plugin-1.2.5.jar
