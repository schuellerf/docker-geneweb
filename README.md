# docker-geneweb
Dockerized installation of Geneweb

## Usage

Usually you want to keep your database so to keep your data in an *existing* directory e.g. `${HOME}/GenealogyData`

Just run the container:
```
docker run --env LANGUAGE=de -d --name geneweb -p2316:2316 -p2317:2317 -v ${HOME}/GenealogyData:/genewebData schuellerf/geneweb:latest
```

and go to [http://localhost:2317](http://localhost:2317)

if you happen to have the git repository you can also execute:
```
./start.sh
```

**note:** the directory `${HOME}/GenealogyData` has to be a *full path*

## Setup
The setup will be started automatically [http://localhost:2316](http://localhost:2316) if no database can be found
		
If you start the container and you already have a database but you want more databases or do some backup you need to start the setup manually like so:

```
docker exec geneweb /start_setup.sh
```
and then navigate to [http://localhost:2316](http://localhost:2316)
## Shutdown

To shutdown the container just run
```
docker stop geneweb
docker rm geneweb
```

## Backup
If you need to do a backup just either backup your data folder (e.g. `${HOME}/GenealogyData`)

To export the data as "*.ged" file or similar you need to start the "setup" tool

```
docker exec -ti geneweb /start_setup.sh
```
and then navigate to [http://localhost:2316](http://localhost:2316)

