#!/bin/bash
set -xeuo pipefail

# TODO: Verify this is ok when restarting container
pushd /shared/koji-source > /dev/null
yum -y localinstall \
    noarch/koji-hub*.rpm \
    noarch/koji-1.*.rpm \
    noarch/koji-web*.rpm
popd > /dev/null

rm -rf /opt/koji-clients
ln -s /shared/koji-clients /opt/koji-clients
rm -rf /etc/pki/koji
ln -s /shared/koji-pki /etc/pki/koji
# TODO: This can probably be removed?
chown -R nobody:nobody /opt/koji-clients

mkdir -p /root/.koji
ln -s /opt/koji-clients/kojiadmin/config /root/.koji/config

for ip in `hostname -I`; do echo 'http://'$ip'/koji'; done
httpd -D FOREGROUND
