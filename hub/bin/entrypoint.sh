#!/bin/bash
set -xeuo pipefail

# TODO: Verify this is ok when restarting container
pushd /opt/koji > /dev/null
yum -y localinstall \
    noarch/koji-hub*.rpm \
    noarch/koji-1.*.rpm \
    noarch/koji-web*.rpm
popd > /dev/null

# TODO: This can probably be removed?
chown -R nobody:nobody /opt/koji-clients

mkdir -p /root/.koji
ln -s /opt/koji-clients/kojiadmin/config /root/.koji/config

for ip in `hostname -I`; do echo 'http://'$ip'/koji'; done
httpd -D FOREGROUND
