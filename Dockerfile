FROM centos:7

MAINTAINER Wolfgang Kulhanek <WolfgangKulhanek@gmail.com>

ENV GOGS_VERSION="0.11.4"

LABEL name="Gogs - Go Git Service" \
      vendor="Gogs" \
      io.k8s.display-name="Gogs - Go Git Service" \
      io.k8s.description="The goal of this project is to make the easiest, fastest, and most painless way of setting up a self-hosted Git service." \
      summary="The goal of this project is to make the easiest, fastest, and most painless way of setting up a self-hosted Git service." \
      io.openshift.expose-services="3000,gogs" \
      io.openshift.tags="gogs" \
      build-date="2017-04-12" \
      version=$GOGS_VERSION \
      release="1"

ENV HOME=/home/gogs

RUN yum -y update && yum -y upgrade \
    && yum -y install epel-release \
    && yum -y install git nss_wrapper gettext \
    && yum -y clean all \
    && adduser gogs \
    && curl -L -o /tmp/gogs.tar.gz https://dl.gogs.io/$GOGS_VERSION/linux_amd64.tar.gz \
    && tar -xzf /tmp/gogs.tar.gz -C /opt \
    && rm /tmp/gogs.tar.gz

COPY ./root /
RUN /usr/bin/fix-permissions /home/gogs \
    && /usr/bin/fix-permissions /opt/gogs
RUN mkdir /data \
    && chown gogs /data \
    && chmod 775 /data

VOLUME /home/gogs/gogs-repositories
# VOLUME /data

EXPOSE 3000
USER 997
ENV USERNAME=gogs

CMD ["/usr/bin/rungogs"]
