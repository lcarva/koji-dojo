#!/bin/bash
set -xeuo pipefail

git clone https://pagure.io/koji.git /opt/local/koji

# install the latest version of python-coverage module
wget https://bootstrap.pypa.io/ez_setup.py
python ez_setup.py
wget https://pypi.python.org/packages/2d/10/6136c8e10644c16906edf4d9f7c782c0f2e7ed47ff2f41f067384e432088/coverage-4.1.tar.gz#md5=80e63edaf49f689d304898fafc1007a5
easy_install coverage-4.1.tar.gz
rm -f coverage-4.1.tar.gz

pushd /opt/local/koji > /dev/null
make test-rpm
yum -y localinstall noarch/koji-1.*.rpm
popd > /dev/null
