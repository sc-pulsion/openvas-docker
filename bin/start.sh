#!/bin/bash

HTTP_ONLY=${HTTP_ONLY:-}
set_http_only=""

if [ "$HTTP_ONLY" = "true" ]; then
  set_http_only="--http-only"
fi

echo "Starting Redis"
mkdir -p /var/run/redis
redis-server /etc/redis/redis.config

cd /usr/local/sbin

echo "Starting gsad"
# http://wiki.openvas.org/index.php/Edit_the_SSL_ciphers_used_by_GSAD
gsad --gnutls-priorities="SECURE128:-AES-128-CBC:-CAMELLIA-128-CBC:-VERS-SSL3.0:-VERS-TLS1.0" $set_http_only

echo "Updating NVTs, CVEs, CPEs..."
openvas-nvt-sync
openvas-scapdata-sync
openvas-certdata-sync

echo "Starting Openvas..."
/etc/init.d/openvas-manager start
/etc/init.d/openvas-scanner start

echo "Starting rebuild process..."
echo "This may take a minute or two..."
openvasmd --rebuild

echo "Checking setup"
/openvas/openvas-check-setup --v8 --server;
echo "Done."

echo "Starting infinite loop..."

echo "Press [CTRL+C] to stop.."

while true
do
	sleep 1
done
