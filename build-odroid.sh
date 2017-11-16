#!/bin/bash

if [ $# -ne 1 ]; then
    echo $0: usage: build-rpi.sh NODE_RED_VERSION
    exit 1
fi

NODE_RED_VERSION=$1

docker build -f odroid/Dockerfile -t nodered/node-red-docker:odroid .

if [ $? -ne 0 ]; then
    echo "ERROR: Docker build failed for odroid image"
    exit 1
fi

docker tag nodered/node-red-docker:odroid nodered/node-red-docker:$NODE_RED_VERSION-odroid

if [ $? -ne 0 ]; then
    echo "ERROR: Docker tag failed for odroid image"
    exit 1
fi

docker run -d nodered/node-red-docker:odroid

if [ $? -ne 0 ]; then
    echo "ERROR: Docker container failed to start for odroid build."
    exit 1
fi

#docker push nodered/node-red-docker:odroid
#
#if [ $? -ne 0 ]; then
#    echo "ERROR: Docker push failed for odroid image."
#    exit 1
#fi
#
#docker push nodered/node-red-docker:$NODE_RED_VERSION-odroid
#
#if [ $? -ne 0 ]; then
#    echo "ERROR: Docker push failed for odroid image."
#    exit 1
#fi
