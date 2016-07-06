#!/bin/bash
set -xeuo pipefail

git clone https://pagure.io/koji.git /opt/local/koji

pip install coverage

pushd /opt/local/koji > /dev/null
make test-rpm
yum -y localinstall noarch/koji-1.*.rpm
popd > /dev/null
