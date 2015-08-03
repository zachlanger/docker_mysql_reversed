#!/bin/bash
# bash kill_container.sh CONTAINER_NAME
docker kill $1
docker rm $1
