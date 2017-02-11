#!/bin/bash
#
# Startup script for PostgresSQL in a Alpine docker.
#
#
# Docker image name 
IMAGE=alpine-db

# PostgreSQL storage directory
PGDATA=$(pwd)/data              # Change this for your settings.

# Port in the host that Postgres will listen 
PGHOST=127.0.0.1:5432           # Change this for your settings. 

docker run -it -v $PGDATA:/data -p $PGHOST:5432 $IMAGE

