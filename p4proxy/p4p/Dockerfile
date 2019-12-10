FROM centos:7
LABEL maintainer "ueno.s <ueno.s@gamestudio.co.jp>"
ENV container docker

# --------------------------------------------------------------------------------
# Docker CentOS 7 install & setup
# --------------------------------------------------------------------------------

# See: https://hub.docker.com/_/centos/
RUN cd /lib/systemd/system/sysinit.target.wants/ && \
    for i in *; do \
        [ $i == systemd-tmpfiles-setup.service ] || rm -vf $i ; \
    done ; \
    rm -vf /lib/systemd/system/multi-user.target.wants/* && \
    rm -vf /etc/systemd/system/*.wants/* && \
    rm -vf /lib/systemd/system/local-fs.target.wants/* && \
    rm -vf /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -vf /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -vf /lib/systemd/system/basic.target.wants/* && \
    rm -vf /lib/systemd/system/anaconda.target.wants/* && \
    mkdir -p /etc/selinux/targeted/contexts/ && \
    echo '<busconfig><selinux></selinux></busconfig>' > /etc/selinux/targeted/contexts/dbus_contexts

RUN yum clean all --enablerepo='*' \
    && yum clean metadata --enablerepo='*' \
    && yum clean all --enablerepo='*' \
    && rm -rf /var/cache/yum

RUN rpm --import https://package.perforce.com/perforce.pubkey
RUN yum-config-manager --add-repo https://gist.githubusercontent.com/hexagrimoire/032c761c748fac87f2e0da9d6b9acc55/raw/52968f498cc618cbfe0a76f189c8ebd26bdefa31/perforce.centos7.repo

RUN yum install -y wget git tzdata sudo helix-p4d helix-proxy
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

# Add external files
COPY files/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# --------------------------------------------------------------------------------
# P4P ENVIRONMENT
# --------------------------------------------------------------------------------

ENV PORT=ssl:1777

ENV P4TARGET=ssl:172.20.16.16:1666

ENV P4HOME=/opt/perforce/servers
ENV P4PCACHE=/opt/perforce/servers/p4p-master
ENV P4SSLDIR=/opt/perforce/servers/ssl
ENV P4PLOGDIR=/opt/perforce/servers/log
ENV P4PLOGFILE=${P4PLOGDIR}/p4p.log

# Default Environment
ENV P4NAME=master
ENV P4TCP=1666
ENV P4PORT=ssl:172.20.16.16:$P4TCP

ENV P4USER=super
ENV P4PASSWD=Passw0rd

# datavolume
ENV P4ROOT=$P4HOME/$P4NAME

RUN sudo -E -u perforce mkdir -p ${P4PCACHE}
RUN sudo -E -u perforce mkdir -p ${P4SSLDIR}
RUN sudo -E -u perforce mkdir -p ${P4PLOGDIR}
RUN sudo -E -u perforce mkdir -p ${P4ROOT}
RUN sudo -E -u perforce chmod 700 ${P4SSLDIR}

RUN sudo -E -u perforce p4d -Gc
RUN sudo -E -u perforce p4d -Gf
RUN sudo -E -u perforce p4 trust -y
RUN sudo -E -u perforce p4p -d -p ${PORT} -t ${P4TARGET} -r ${P4PCACHE} -L ${P4PLOGFILE} -v 3

CMD ["/sbin/init"]
