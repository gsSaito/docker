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
RUN yum install -y centos-release-scl
RUN yum install -y wget \ 
                git \
                tzdata \
                helix-p4d \
                helix-saml \
                gcc \
                openssl-devel \
                bzip2-devel \
                libffi-devel \
                make \
                unzip \
                libxml2-devel \
                xmlsec1-devel \
                xmlsec1-openssl \
                xmlsec1-openssl-devel \
                libtool-ltdl-devel \
                rh-python36 \
                rh-python36-python-devel \
                rh-python36-python-virtualenv

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.local/bin/

WORKDIR /usr/src
RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
RUN tar xzf Python-3.7.4.tgz

WORKDIR /usr/src/Python-3.7.4

RUN ./configure --enable-optimizations
RUN make altinstall
RUN rm /usr/src/Python-3.7.4.tgz
RUN ln -s /usr/local/bin/python3.7 /usr/local/bin/python3
RUN python3 -m pip install --user pipenv
RUN pip3.7 install --upgrade pip
RUN pipenv install requests
RUN python3 -m virtualenv --python=python3 pysaml
RUN source pysaml/bin/activate
RUN python3 -m pip install --upgrade pip

WORKDIR /opt/

RUN python3 -m pip install requests six lxml xmlsec isodate defusedxml python3-saml

RUN wget https://swarm.workshop.perforce.com/projects/perforce_software-helix-saml/archives/main.zip
RUN unzip main.zip
RUN python3 -m pip install -r ./main/requirements.txt
