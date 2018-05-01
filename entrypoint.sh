#!/bin/bash

java \
  -Dserver.hostname=${RDECK_HOSTNAME} \
  -jar /usr/local/src/rundeck-launcher-${RDECK_VERSION}.jar \
    -b ${RDECK_BASE}