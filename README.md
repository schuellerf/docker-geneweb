# docker-geneweb
Dockerized installation of Geneweb

The container does not include `gwsetup` by default but this is only installed once to create a database

*hint:* `gwsetup` is the program to create a genealogy database initially

## Usage

Usually you want to keep your database so to keep your data in an *existing* directory e.g. `${HOME}/GenealogyData`

Just run the container:
```
docker run --env LANGUAGE=de -d --name docker-geneweb -p2316:2316 -p2317:2317 -v ${HOME}/GenealogyData:/genewebData docker-geneweb:latest
```

and go to [http://localhost:2317](http://localhost:2317)

if you happen to have the git repository you can also execute:
```
./start.sh
```

**note:** the directory `${HOME}/GenealogyData` has to be a *full path*

## Setup
The setup will be started automatically [http://localhost:2316](http://localhost:2316) if no database can be found
		
**Please be patient** the setup tool will be installed "on the fly" only upon the *first start* if you don't have any genealogy database.

If you start the container and you already have a database but you want more databases or do some backup you need to start the setup manually like so:

```
docker exec docker-geneweb /start_setup.sh
```
and then navigate to [http://localhost:2316](http://localhost:2316)
## Shutdown

To shutdown the container just run
```
docker stop docker-geneweb
docker rm docker-geneweb
```

## Backup
If you need to do a backup just either backup your data folder (e.g. `${HOME}/GenealogyData`)

To export the data as "*.ged" file or similar you need to start the "setup" tool

```
docker exec -ti docker-geneweb /start_setup.sh
```
and then navigate to [http://localhost:2316](http://localhost:2316)

