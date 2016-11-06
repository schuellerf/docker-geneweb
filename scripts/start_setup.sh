#!/usr/bin/env bash

pushd ${GENEWEBDB}
    gwsetup -p ${SETUP_PORT} -gd ${GENEWEBSHARE} -lang ${LANGUAGE} -only /setup_ips.txt -log ${SETUP_LOGFILE} &
popd
