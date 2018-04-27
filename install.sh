#!/bin/bash

INS_PATH=$1
echo INS_PATH: $INS_PATH
[[ -n $INS_PATH ]] || INS_PATH="/opt/tflow"
echo Install tflow to $INS_PATH

[[ -d $INS_PATH ]] || mkdir -p $INS_PATH

cp -rf * /opt/tflow/

echo "PATH=\$PATH:$INS_PATH" >> /etc/profile

echo Install finished
echo Please run \"source /etc/profile\" to take effect
