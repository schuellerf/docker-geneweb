FROM i386/debian:wheezy

LABEL maintainer="Wolfgang Hottgenroth <wolfgang.hottgenroth@icloud.com>, Florian Schüller <florian.schueller@gmail.com>"

ARG GENEWEB_UID="2317"
ARG GENEWEB_GID="2317"


# This is where your data is
ENV GENEWEBDB     /genewebData
ENV GENEWEBSHARE  /opt/geneweb/gw

# HTTP Port where geneweb is running
ENV PORT         2317

# HTTP Port only used for setup purposes (when you don't have a database yet)
ENV SETUP_PORT   2316

# Language of interface and setup
ENV LANGUAGE     de

EXPOSE ${PORT}
EXPOSE ${SETUP_PORT}

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get -y install ca-certificates wget && \
  rm -rf /var/lib/apt/lists/* 

RUN \
  echo "75f55ac1d0aca82faee57a617bbced26  gw-5.02-linux.tar" > /tmp/gw-chksum

COPY scripts/bootstrap.sh /
RUN chmod a+x /bootstrap.sh

RUN \
  cd /tmp && wget https://github.com/geneweb/geneweb/releases/download/v5.02/gw-5.02-linux.tar && \
  md5sum --check gw-chksum && \ 
  tar -xf gw-5.02-linux.tar && \
  cd /opt && mkdir geneweb && \
  mv /tmp/distribution/* /opt/geneweb && \
  groupadd -r -g $GENEWEB_GID geneweb && \
  useradd -r -u $GENEWEB_UID -g geneweb geneweb && \
  chown -R geneweb:geneweb /opt/geneweb && \
  mkdir $GENEWEBDB && \
  chown geneweb:geneweb $GENEWEBDB

COPY scripts/start_setup.sh /
RUN chmod a+x /start_setup.sh

VOLUME ${GENEWEBDB}

# The IP of the Docker host - setup needs this to enable access
ENV HOST_IP      172.17.0.1

RUN echo ${HOST_IP} > ${GENEWEBDB}/setup_ips.txt

VOLUME ${GENEWEBDB}

USER geneweb
CMD ["/bootstrap.sh"]
