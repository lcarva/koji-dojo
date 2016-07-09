#!/bin/bash

# TODO: Remove this once builder is pre-configured
while true; do
	echo "Waiting for koji-hub to start..."
    hubstart=$(curl -X GET http://koji-hub/)
	echo $hubstart
	if [ "x$hubstart" != "x" ]; then
		echo "koji-hub started:"
	    break
	fi
	sleep 5
done

set -xeuo pipefail

yum -y localinstall /opt/koji/noarch/koji-1*.rpm

prepare_builder.sh

# Start koji builder
exec /usr/sbin/kojid -f --force-lock
