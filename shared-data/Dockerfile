FROM centos:centos6
MAINTAINER Luiz Carvalho <lucarval@redhat.com>

RUN sed -i '/nodocs/d' /etc/yum.conf

VOLUME ["/opt/koji", "/opt/koji-clients", "/etc/pki/koji"]
EXPOSE 80

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install \
        git \
        httpd \
        make \
        python-pip \
        python-sphinx \
        rpm-build \
    ; yum clean all

ADD opt/ /opt/
ADD etc/ /etc/
ADD bin/ /usr/local/bin/
ADD root/ /root/

RUN /usr/local/bin/setup.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
