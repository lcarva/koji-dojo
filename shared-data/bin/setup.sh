#!/bin/bash
set -xeuo pipefail

create_koji_folders() {
	echo "Create Koji folders"

	cd /mnt
	mkdir koji
	cd koji
	mkdir {packages,repos,work,scratch}
	chown apache.apache *
}

generate_ssl_certificates() {
	echo "Generate SSL certificates"

	mkdir -p /opt/local/pki/koji/{certs,private,confs}

	cd /opt/local/pki/koji

	touch index.txt
	echo 01 > serial

	# CA
	conf=confs/ca.cnf
	cp ssl.cnf $conf

	openssl genrsa -out private/koji_ca_cert.key 2048
	openssl req -config $conf -new -x509 -subj "/C=US/ST=Drunken/L=Bed/O=IT/CN=koji-hub" -days 3650 -key private/koji_ca_cert.key -out koji_ca_cert.crt -extensions v3_ca

	cp private/koji_ca_cert.key private/kojihub.key
	cp koji_ca_cert.crt certs/kojihub.crt

	mkuser.sh kojiweb admin
	mkuser.sh kojiadmin admin
	mkuser.sh testadmin admin
	mkuser.sh testuser

	chown -R nobody:nobody /opt/local/koji-clients
}

create_koji_config_for_root() {
	echo "Create /root/.koji/config for user root"

	mkdir /root/.koji

	cat <<EOF >> /root/.koji/config
[koji]
server = https://localhost/kojihub
authtype = ssl
cert = /opt/koji-clients/kojiadmin/client.crt
ca = /opt/koji-clients/kojiadmin/clientca.crt
serverca = /opt/koji-clients/kojiadmin/serverca.crt
EOF
}

if [ -d /mnt/koji ]
then
    echo "Koji folders exist"
else
	create_koji_folders
fi

if [ -f /opt/local/pki/koji/certs/kojihub.crt ]
then
    echo "Ssl certificates already generated"
else
	generate_ssl_certificates
fi

if [ -f /root/.koji/config ]
then
    echo "Ssl certificates already generated"
else
	create_koji_config_for_root
fi

