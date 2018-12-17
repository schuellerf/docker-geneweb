#!/usr/bin/env bash

mkdir -p ${HOME}/GenealogyData
docker rm docker-geneweb 2>/dev/null
docker run --user=$(id -u):$(id -g) --env LANGUAGE=de -d --name geneweb -p2316:2316 -p2317:2317 -v ${HOME}/GenealogyData:/genewebData schuellerf/geneweb:geneweb5-latest

echo "If you don't have any database - go to http://localhost:2316 to create one"
echo "or your server should be ready here: http://localhost:2317"
