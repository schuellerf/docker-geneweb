FROM ubuntu:16.04

MAINTAINER Florian Schüller <florian.schueller@gmail.com>

# This is where your data is
ENV GENEWEBDB     /genewebData

# Location specific to ubuntu installation
ENV GENEWEBSHARE  /usr/share/geneweb
# Location specific to ubuntu installation
ENV GENEWEBDOC    /usr/share/doc/geneweb

# Temporary logfile used for setup
ENV SETUP_LOGFILE /tmp/setup_log.txt

# HTTP Port where geneweb is running
ENV PORT         2317

# HTTP Port only used for setup purposes (when you don't have a database yet)
ENV SETUP_PORT   2316

# Language of interface and setup
ENV LANGUAGE     de

EXPOSE ${PORT}
EXPOSE ${SETUP_PORT}

RUN \
  apt-get update && \
  apt-get -y install --no-install-recommends gwsetup geneweb && \
  rm -rf /var/lib/apt/lists/*

# seems to be some bug of "gwsetup"
RUN ln -s /usr/bin/gwc2 /usr/share/geneweb/gwc2
RUN ln -s /usr/bin/gwb2ged /usr/share/geneweb/gwb2ged
RUN ln -s /usr/bin/gwu /usr/share/geneweb/gwu

COPY scripts/bootstrap.sh /
RUN chmod a+x /bootstrap.sh

COPY scripts/start_setup.sh /
RUN chmod a+x /start_setup.sh

VOLUME ${GENEWEBDB}

# The IP of the Docker host - setup needs this to enable access
ENV HOST_IP      172.17.0.1

RUN echo ${HOST_IP} > /setup_ips.txt

CMD ["/bootstrap.sh"]
