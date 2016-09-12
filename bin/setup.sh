#!/bin/bash

# Adapted test from http://www.openvas.org/install-packages-v6.html

echo "Starting setup..."

mkdir -p /var/run/redis
redis-server /etc/redis/redis.config
ldconfig

test -e /var/lib/openvas/CA/cacert.pem  || openvas-mkcert -q
test -e /var/lib/openvas/users/om || openvas-mkcert-client -n om -i

service openvas-manager stop
service openvas-scanner stop

openvas-nvt-sync
openvas-scapdata-sync
openvas-certdata-sync

echo "Setting Admin user password..."
openvasmd --user=admin --new-password=openvas

echo "Finished setup..."
