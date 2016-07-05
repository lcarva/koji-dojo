#!/bin/bash
set -xeuo pipefail

# Expose built stuff in volume
# TODO: Check before cleaning volume?
rm -rf /shared/*
cp -r /opt/koji /shared/koji-source
cp -r /opt/koji-clients /shared/koji-clients
cp -r /etc/pki/koji /shared/koji-pki

for ip in `hostname -I`; do echo 'http://'$ip'/shared'; done
httpd -D FOREGROUND