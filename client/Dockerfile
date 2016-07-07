FROM centos:centos6
MAINTAINER Luiz Carvalho <lucarval@redhat.com>

RUN yum -y update \
    ; yum clean all

ADD bin/ /usr/local/bin/

RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
