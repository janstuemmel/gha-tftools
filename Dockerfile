FROM ubuntu:focal

ARG TFENV_VERSION=2.2.2
ARG TFTOOLS_INSTALLDIR=/tools

ENV TFTOOLS_INSTALLDIR=${TFTOOLS_INSTALLDIR}
ENV TFENV_VERSION=${TFENV_VERSION}

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl wget unzip \
 && apt-get clean \
 && rm -rf /tmp/* \
 && rm -rf /var/lib/apt

COPY install_tftools.sh /usr/local/bin/install_tftools.sh

ENTRYPOINT ["/usr/local/bin/install_tftools.sh"]
