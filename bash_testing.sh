#!/bin/sh

IPADDRESS1=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' ubuntu_slave)
IPADDRESS2=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' ubuntu_slave2)

sed "s/IPADDRESS/$IPADDRESS1/" jenkins_files/slave1/config > jenkins_files/slave1/config.xml
sed "s/IPADDRESS/$IPADDRESS2/" jenkins_files/slave2/config > jenkins_files/slave2/config.xml
