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
RUN yum install -y wget git tzdata helix-p4d

# --------------------------------------------------------------------------------
# HelixCore FILE COPY
# --------------------------------------------------------------------------------

# Add external files
COPY files/init.sh /usr/local/bin/init.sh
COPY files/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/run.sh

# --------------------------------------------------------------------------------
# HelixCore ENVIRONMENT
# --------------------------------------------------------------------------------

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

ARG P4NAME=master
ARG P4TCP=1666
ARG P4USER=super
ARG P4PASSWD=Passw0rd
ARG P4CASE=-C0

# Default Environment
ENV P4NAME=$P4NAME \
    P4TCP=$P4TCP \
    P4PORT=ssl:$P4TCP \
    P4USER=$P4USER \
    P4PASSWD=$P4PASSWD \
    P4HOME=/opt/perforce/servers \
    P4ROOT=$P4HOME/$P4NAME \
    CASE_INSENSITIVE=y

# --------------------------------------------------------------------------------
# HelixCore Created & start
# --------------------------------------------------------------------------------

RUN run.sh
