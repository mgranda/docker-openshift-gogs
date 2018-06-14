FROM centos:7
MAINTAINER Wolfgang Kulhanek <WolfgangKulhanek@gmail.com>

# Set the Gogs Version to install.
# Check https://dl.gogs.io/ for available versions.
ENV GOGS_VERSION="0.11.53"

LABEL name="Gogs - Go Git Service" \
      vendor="Gogs" \
      io.k8s.display-name="Gogs - Go Git Service" \
      io.k8s.description="The goal of this project is to make the easiest, fastest, and most painless way of setting up a self-hosted Git service." \
      io.openshift.expose-services="3000,gogs" \
      io.openshift.tags="gogs" \
      build-date="2018-06-14" \
      version=$GOGS_VERSION \
      release="1"

# Install Prerequisites
# nss_wrapper is needed for matching the OpenShift
# assigned UserID to the `gogs` user when the container
# is running in OpenShift. See `/root/usr/bin/rungogs`
# shell script for how to use it.
RUN yum -y update && yum -y upgrade \
    && yum -y install epel-release \
    && yum -y install git nss_wrapper \
    && yum -y clean all 

RUN adduser gogs \
    && curl -L -o /tmp/gogs.tar.gz https://dl.gogs.io/${GOGS_VERSION}/gogs_${GOGS_VERSION}_linux_amd64.tar.gz \
    && gunzip /tmp/gogs.tar.gz \
    && tar -xf /tmp/gogs.tar -C /opt \
    && rm /tmp/gogs.tar

COPY ./root /
RUN mkdir /data \
    && /usr/bin/fix-permissions /data \
    && /usr/bin/fix-permissions /opt/gogs

ENV HOME=/data
ENV USERNAME=gogs

VOLUME /data

EXPOSE 3000
USER 997

CMD ["/usr/bin/rungogs"]
