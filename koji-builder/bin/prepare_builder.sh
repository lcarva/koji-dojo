#!/bin/bash

set -ex

yum -y install git python-setuptools epel-release
yum -y localinstall /opt/koji/noarch/koji-hub* /opt/koji/noarch/koji-builder-*.rpm

# TODO: the guide requires httpd to be restarted on koji hub

# Install osbs-client
# TODO: Consider doing this at build time with pip?
rm -rf ~/osbs-client
git clone https://github.com/projectatomic/osbs-client.git ~/osbs-client
cd ~/osbs-client
python setup.py install
mkdir -p /usr/share/osbs
cp inputs/* /usr/share/osbs

# Install koji-containerbuild
# TODO: Consider doing this at build time with pip?
rm -rf ~/koji-containerbuild
git clone https://github.com/release-engineering/koji-containerbuild.git ~/koji-containerbuild
cd ~/koji-containerbuild
git checkout develop
git rev-parse HEAD
# Remove install_requires
sed -i -e '/"koji",/d' -e '/"osbs",/d' setup.py
python setup.py install
mkdir -p /usr/lib/koji-builder-plugins
cp koji_containerbuild/plugins/builder_containerbuild.py /usr/lib/koji-builder-plugins/builder_containerbuild.py

# TODO: Verify this is ok on container restart
koji -c /opt/koji-clients/kojiadmin/config add-host kojibuilder x86_64 || true
koji -c /opt/koji-clients/kojiadmin/config add-host-to-channel kojibuilder container --new || true
