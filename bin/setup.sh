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

echo "Updating NVTs, CVEs, CPEs..."
openvas-nvt-sync
openvas-scapdata-sync
openvas-certdata-sync

echo "Setting Admin user password..."
openvasmd --user=admin --new-password=openvas

echo "Starting Openvas..."
service openvas-manager start
service openvas-scanner start

# Slow initial rebuild
# Also stops OID's being shown instead of vulnerability title when first run
echo "Starting rebuild process..."
echo "This may take a minute or two..."
openvasmd --rebuild --progress

echo "Finished setup..."
