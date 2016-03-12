FROM centos:7
MAINTAINER Amit Malhotra <amalhotra@premiumbeat.com>

# Set US locale (localegen on ubuntu)
RUN localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANGUAGE en_US
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN yum clean all && \
    yum update -y && \
    yum install -y epel-release && \
    yum install -y http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum install -y python-pip \
    python34.x86_64 \
    python34-devel.x86_64 \
    postgresql-devel \
    python-devel \
    wget \
    vorbis-tools \
    sox \
    lame \
    gcc

# Install pip for python3
RUN curl https://bootstrap.pypa.io/get-pip.py | python3 -

# Install supervisor
RUN pip2 install supervisor
RUN mkdir /var/log/supervisor

# Setup the system for requirements installation
COPY templates/etc/supervisord.conf /etc/supervisord.conf

WORKDIR /tmp
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r requirements.txt
