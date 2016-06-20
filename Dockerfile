FROM centos:7 

MAINTAINER Eduardo Gonzalez Gutierrez <dabarren@gmail.com>

COPY jpackage-generic.repo /etc/yum.repos.d/jpackage-generic.repo

RUN yum install -y http://yum.spacewalkproject.org/2.5/RHEL/7/x86_64/spacewalk-repo-2.5-3.el7.noarch.rpm \
        epel-release && \
        yum clean all

RUN yum -y install \
        spacewalk-setup-postgresql \
        spacewalk-postgresql && \
        yum clean all

COPY answerfile.txt /tmp/answerfile.txt

EXPOSE 80 443

RUN spacewalk-setup --answer-file /tmp/answerfile.txt 
