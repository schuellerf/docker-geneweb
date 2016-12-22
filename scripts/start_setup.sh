#!/usr/bin/env bash

pushd ${GENEWEBDB}
    if [ -n "${HOST_IP}" ]; then
       echo "${HOST_IP}" > /setup_ips.txt
    fi
    gwsetup -p${SETUP_PORT} -gd${GENEWEBSHARE} -lang${LANGUAGE} -log${SETUP_LOGFILE} -only/setup_ips.txt
popd
