#!/usr/bin/env bash


# no database found - we need the setup
if [ $(ls ${GENEWEBDB}/*.gwb 2>/dev/null|wc -l) -eq 0 ]; then
    /start_setup.sh &
fi

/opt/geneweb/gw/gwd -lang${LANGUAGE} -hd${GENEWEBSHARE} -bd${GENEWEBDB} -p${PORT}
