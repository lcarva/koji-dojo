#!/bin/bash
set -euo pipefail

yum -y localinstall /opt/koji/noarch/koji-1*.rpm

rm -rf /root/{.koji,bin}
mkdir -p /root/{.koji,bin}

for userdir in $(ls -d /opt/koji-clients/*); do
	user=$(basename $userdir)

    # Create a koji profile for each user
	cat << EOF >> /root/.koji/config
[koji-${user}]
server = https://koji-hub/kojihub
authtype = ssl
cert = ${userdir}/client.crt
ca = ${userdir}/clientca.crt
serverca = ${userdir}/serverca.crt

EOF

    # Create symbolic link for each user
	ln -s /usr/bin/koji /root/bin/koji-${user}
done

echo "Generated configs are:"
cat /root/.koji/config

echo "Available user-specific koji commands are:"
ls -1 /root/bin/koji-*

# Keep container around so "docker exec" can be
# run against it, but gracefully exit on SIGTERM
trap 'exit 0' SIGTERM
while true; do sleep 2; done
