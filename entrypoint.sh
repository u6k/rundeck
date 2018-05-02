#!/bin/bash

sed -i -e "s/^grails\.serverURL.*$/grails\.serverURL=${RDECK_URL}/g" ${RDECK_BASE}/server/config/rundeck-config.properties

sed -i -e "/^admin/s/^/#/g" ${RDECK_BASE}/server/config/realm.properties
sed -i -e "/^user/s/^/#/g" ${RDECK_BASE}/server/config/realm.properties
echo ${RDECK_ADMIN_USER}:${RDECK_ADMIN_PASS},admin,user >>${RDECK_BASE}/server/config/realm.properties

java \
  -jar /usr/local/src/rundeck-launcher-${RDECK_VERSION}.jar \
    --skipinstall \
    -b ${RDECK_BASE}
