FROM centos:7 

MAINTAINER Eduardo Gonzalez Gutierrez <dabarren@gmail.com>

COPY jpackage-generic.repo /etc/yum.repos.d/jpackage-generic.repo

RUN yum install -y http://yum.spacewalkproject.org/2.5/RHEL/7/x86_64/spacewalk-repo-2.5-3.el7.noarch.rpm \
        epel-release && \
        yum clean all

RUN rpm --import http://www.jpackage.org/jpackage.asc && \
    rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 && \
    rpm --import http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015 && \
    yum clean all

RUN yum -y install \
        spacewalk-setup-postgresql && \
        yum clean all

RUN yum -y install \
        spacewalk-postgresql && \
        yum clean all

COPY answerfile.txt /tmp/answerfile.txt

EXPOSE 80 443 5222 68 69

USER root

RUN yum install -y supervisor && \
    yum clean all

ADD supervisord.conf /etc/supervisord.d/supervisord.conf

RUN supervisord -c /etc/supervisord.d/supervisord.conf
