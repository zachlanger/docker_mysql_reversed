#!/bin/bash

ssh-keygen -q -b 4096 -t rsa -f /root/.ssh/id_rsa -P ""
cd /root
chmod 700 .ssh
cd .ssh
touch authorized_keys
chmod 600 authorized_keys
cat id_rsa.pub >> authorized_keys
rm id_rsa.pub
