FROM i386/debian:wheezy

MAINTAINER Wolfgang Hottgenroth <wolfgang.hottgenroth@icloud.com>

ARG GENEWEB_UID="2317"
ARG GENEWEB_GID="2317"


# This is where your data is
ENV GENEWEBDB     /genewebData
ENV GENEWEBSHARE  /opt/geneweb/gw

# HTTP Port where geneweb is running
ENV PORT         2317

# Language of interface and setup
ENV LANGUAGE     de

EXPOSE ${PORT}

RUN \
  apt-get update && \
  apt-get -y install  wget && \
  rm -rf /var/lib/apt/lists/* 

RUN \
  echo "75f55ac1d0aca82faee57a617bbced26  gw-5.02-linux.tar" > /tmp/gw-chksum

RUN \
  cd /tmp && wget --no-check-certificate https://github.com/geneweb/geneweb/releases/download/v5.02/gw-5.02-linux.tar && \
  md5sum --check gw-chksum && \ 
  tar -xf gw-5.02-linux.tar && \
  cd /opt && mkdir geneweb && \
  mv /tmp/distribution/* /opt/geneweb && \
  groupadd -r -g $GENEWEB_GID geneweb && \
  useradd -r -u $GENEWEB_UID -g geneweb geneweb && \
  chown -R geneweb:geneweb /opt/geneweb && \
  mkdir $GENEWEBDB && \
  chown geneweb:geneweb $GENEWEBDB



COPY scripts/bootstrap.sh /
RUN chmod a+x /bootstrap.sh 

COPY scripts/README-SETUP.txt /


VOLUME ${GENEWEBDB}

USER geneweb
CMD ["/bootstrap.sh"]

