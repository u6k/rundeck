FROM rundeck/rundeck:3.2.5
LABEL maintainer="u6k.apps@gmail.com"

# Install Rundeck plugin
RUN curl -L -o /home/rundeck/libext/slack-incoming-webhook-plugin.jar https://github.com/rundeck-plugins/slack-incoming-webhook-plugin/releases/download/v1.2.5/slack-incoming-webhook-plugin-1.2.5.jar

# Install softwares
#RUN apt -y install awscli p7zip-full
