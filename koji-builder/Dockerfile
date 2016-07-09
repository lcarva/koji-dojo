FROM centos:centos6
MAINTAINER Luiz Carvalhow <lucarval@redhat.com>

RUN yum -y update && \
    yum -y install \
        git \
        python-simplejson \
    ; yum clean all

ADD etc/ /etc/
ADD bin/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
