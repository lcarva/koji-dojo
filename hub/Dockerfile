FROM centos:centos6
MAINTAINER Luiz Carvalho <lucarval@redhat.com>

EXPOSE 80 443

RUN yum -y update && \
    yum -y install \
        httpd \
        mod_auth_kerb \
        mod_ssl \
        mod_wsgi \
        python-simplejson \
    ; yum clean all

ADD etc/ /etc/
ADD bin/ /usr/local/bin/

RUN chmod +x /usr/local/bin/* && \
    mkdir -p /mnt/koji/{packages,repos,work,scratch} && \
    chown apache.apache /mnt/koji/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
