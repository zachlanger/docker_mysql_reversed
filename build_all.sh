#!/bin/bash

# Remove previous containers
docker kill ubuntu_slave
docker kill ubuntu_slave2
docker kill jenkins
docker rm ubuntu_slave
docker rm ubuntu_slave2
docker rm jenkins

# Build Slave 1
cd ubuntu_slave/
docker build -t zlanger/dockerubuntu .
docker run --name ubuntu_slave -t zlanger/dockerubuntu &
TASK_PID=$!
sleep 5
kill $TASK_PID

# Build Slave 2
docker run --name ubuntu_slave2 -t zlanger/dockerubuntu &
TASK_PID=$!
sleep 5
kill $TASK_PID

# Build Jenkins
cd ../jenkins

# Connect Jenkins to IP addresses of the containers
IPADDRESS1=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' ubuntu_slave)
IPADDRESS2=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' ubuntu_slave2)

sed "s/IPADDRESS/$IPADDRESS1/" slave1/config > slave1/config.xml
sed "s/IPADDRESS/$IPADDRESS2/" slave2/config > slave2/config.xml

docker cp ubuntu_slave:/root/.ssh/authorized_keys $PWD/
docker cp ubuntu_slave:/root/.ssh/id_rsa $PWD/
docker build -t zlanger/dockerjenkins .
docker run -p 8080:8080 --name jenkins --privileged -d zlanger/dockerjenkins

rm authorized_keys
rm id_rsa

sleep 5
open "http://192.168.99.100:8080"
open "http://localhost:8080"
