FROM centos:centos6
MAINTAINER Luiz Carvalho <lucarval@redhat.com>

RUN sed -i '/nodocs/d' /etc/yum.conf

VOLUME ["/opt/koji", "/opt/koji-clients", "/etc/pki/koji"]

RUN yum -y update && \
    yum -y install \
        PyGreSQL \
        bzip2 \
        git \
        httpd \
        lsof \
        make \
        mod_auth_kerb \
        mod_ssl \
        mod_wsgi \
        openssh-server \
        patch \
        postgresql \
        pyOpenSSL \
        python-cheetah \
        python-coverage \
        python-krbV \
        python-markdown \
        python-pygments \
        python-qpid \
        python-saslwrapper \
        python-setuptools \
        python-simplejson \
        python-sphinx \
        rpm-build \
        saslwrapper \
        sudo \
        tar \
        wget \
        yum-utils \
    ; yum clean all

ADD opt/ /opt/
ADD etc/ /etc/
ADD bin/ /usr/local/bin/
ADD root/ /root/

RUN chmod 600 /root/.pgpass
RUN chmod +x /usr/local/bin/*

RUN mkdir -p /mnt/koji/{packages,repos,work,scratch}
RUN chown apache.apache /mnt/koji/*
RUN echo 'root:mypassword' | chpasswd

EXPOSE 80

RUN mkdir -p /opt/local
RUN /usr/local/bin/build-koji.sh
RUN /usr/local/bin/setup.sh

ENTRYPOINT /usr/local/bin/entrypoint.sh
