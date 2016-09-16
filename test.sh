#!/bin/bash

#docker build -t openvas /home/scampbell/openvas-docker

docker run -d -p 443:443 -p 9390:9390 -p 9391:9391 -v /dev/urandom:/dev/random -v /home/scampbell/openvasDB:/var/lib/openvas/mgr --name openvas openvas

echo "Waiting for startup to complete..."
until docker logs --tail=15 openvas | grep -E 'It seems like your OpenVAS-8 installation is'; do
  echo "." ;
  echo "=========================================================================";
  docker logs --tail=15 openvas
  echo "=========================================================================";
  sleep 5 ;
done

docker logs --tail=15 openvas | grep -E 'It seems like your OpenVAS-8 installation is OK'


## To do
## Enable mail alerts
