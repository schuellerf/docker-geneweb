#!/usr/bin/env bash

pushd ${GENEWEBDB}
    gwsetup -p${SETUP_PORT} -gd${GENEWEBSHARE} -lang${LANGUAGE} -log${SETUP_LOGFILE} -only/setup_ips.txt
popd
