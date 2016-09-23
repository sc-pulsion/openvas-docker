#!/bin/bash

echo "Starting Redis"
mkdir -p /var/run/redis
redis-server /etc/redis/redis.config

cd /usr/local/sbin

echo "Starting gsad"
gsad --gnutls-priorities="SECURE256:-VERS-TLS-ALL:+VERS-TLS1.2"

echo "Starting w3af..."
openvasmd --modify-scanner=`openvasmd --get-scanners | grep "OSP w3af" | cut -c1-36` --scanner-ca-pub=/var/lib/openvas/CA/cacert.pem --scanner-key-pub=/var/lib/openvas/CA/clientcert.pem --scanner-key-priv=/var/lib/openvas/private/CA/clientkey.pem
ospd-w3af -p 9392 -k /var/lib/openvas/private/CA/clientkey.pem -c /var/lib/openvas/CA/clientcert.pem --ca-file /var/lib/openvas/CA/cacert.pem --background

echo "Updating NVTs, CVEs, CPEs..."
openvas-nvt-sync
openvas-scapdata-sync
openvas-certdata-sync

echo "Starting Openvas..."
service openvas-manager start
service openvas-scanner start

echo "Updating IANA service names..."
wget http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xml
openvas-portnames-update service-names-port-numbers.xml
rm service-names-port-numbers.xml

echo "Starting rebuild process..."
echo "This may take a minute or two..."
openvasmd --rebuild
service openvas-manager restart

# Check whether an admin user already exists
if ! openvasmd --get-users | grep -q admin; then

    # Add the user
    echo "Adding new admin user..."
    openvasmd --create-user=admin --role=Admin
    echo "Setting Admin user password..."
    openvasmd --user=admin --new-password=openvas

    # Since this is a first time run we need to rebuild again to fix OIDs displaying instead of titles
    openvasmd --rebuild
    service openvas-manager restart

fi
	
echo "Starting sendmail..."
service sendmail start

echo "Checking setup"
/openvas/openvas-check-setup --v8 --server
echo "Done."

echo "Starting infinite loop..."
echo "Press [CTRL+C] to stop.."

while true
do
	sleep 1
done
