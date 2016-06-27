FROM centos:7
MAINTAINER Naveen "naveen@diamanti.com"
ENV container docker

RUN yum -y update; yum clean all

RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs dbus

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

ADD dbus.service /etc/systemd/system/dbus.service
RUN systemctl enable dbus.service

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD  ["/usr/sbin/init"]
