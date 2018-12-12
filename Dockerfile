FROM i386/debian:wheezy

MAINTAINER Wolfgang Hottgenroth <wolfgang.hottgenroth@icloud.com>

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
  cd /tmp && wget --no-check-certificate https://github.com/geneweb/geneweb/releases/download/v5.02/gw-5.02-linux.tar && \
  tar -xf gw-5.02-linux.tar && \
  cd /opt && mkdir geneweb && \
  mv /tmp/distribution/* /opt/geneweb 


COPY scripts/bootstrap.sh /
RUN chmod a+x /bootstrap.sh 

COPY scripts/README-SETUP.txt /


VOLUME ${GENEWEBDB}

CMD ["/bootstrap.sh"]

