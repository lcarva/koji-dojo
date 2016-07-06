#!/bin/bash
set -xeuo pipefail

# TODO: Verify this is ok when restarting container
yum -y localinstall \
    /opt/koji/noarch/koji-hub*.rpm \
    /opt/koji/noarch/koji-1.*.rpm \
    /opt/koji/noarch/koji-web*.rpm

# TODO: This can probably be removed?
chown -R nobody:nobody /opt/koji-clients

mkdir -p /root/.koji
ln -s /opt/koji-clients/kojiadmin/config /root/.koji/config

for ip in `hostname -I`; do echo 'http://'$ip'/koji'; done
httpd -D FOREGROUND
