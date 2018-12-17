#!/usr/bin/env bash

pushd ${GENEWEBDB}
    if [ -n "${HOST_IP}" ]; then
       echo "${HOST_IP}" > ${GENEWEBDB}/setup_ips.txt
    fi
    /opt/geneweb/gw/gwsetup -p${SETUP_PORT} -gd${GENEWEBSHARE} -lang${LANGUAGE} -only${GENEWEBDB}/setup_ips.txt
popd

