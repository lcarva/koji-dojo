FROM centos:centos6
MAINTAINER John Casey <jcasey@redhat.com>

RUN sed -i '/nodocs/d' /etc/yum.conf

RUN yum -y update && \
    yum -y install \
        PyGreSQL \
        bzip2 \
        git \
        httpd \
        lsof \
        mod_auth_kerb \
        mod_ssl \
        mod_wsgi \
        openssh-server \
        patch \
        postgresql \
        postgresql-python \
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
        saslwrapper \
        sudo \
        tar \
        wget \
        yum-utils \
    ; yum clean all

ADD etc/ /etc/
ADD bin/ /usr/local/bin/
ADD root/ /root/

RUN chmod 600 /root/.pgpass
RUN chmod +x /usr/local/bin/*

RUN mkdir -p /mnt/koji/{packages,repos,work,scratch}
RUN chown apache.apache /mnt/koji/*
RUN echo 'root:mypassword' | chpasswd

EXPOSE 80 443

ENTRYPOINT /usr/local/bin/entrypoint.sh
