#!/bin/bash
set -xeuo pipefail

yum -y localinstall \
    /opt/koji/noarch/koji-hub*.rpm \
    /opt/koji/noarch/koji-1.*.rpm \
    /opt/koji/noarch/koji-web*.rpm

mkdir -p /root/.koji
ln -s /opt/koji-clients/kojiadmin/config /root/.koji/config

for ip in `hostname -I`;
do
    echo 'http://'$ip'/koji';
    echo 'http://'$ip'/kojifiles';
done
httpd -D FOREGROUND
