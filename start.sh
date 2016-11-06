#!/usr/bin/env bash


mkdir -p ${HOME}/GenealogyData
docker rm docker-geneweb 2>/dev/null
docker run -d --name docker-geneweb -p2316:2316 -p2317:2317 -v ${HOME}/GenealogyData:/genewebData docker-geneweb:latest
