#!/bin/bash

RESULT=$(ping -c 1 localhost)

if [ $? -ne 0 ]; then
    echo "Host is down | status=1;;1;0;1"
    echo ${RESULT}
    exit 1
else
    echo "Host is up | status=0;;1;0;1"
    echo ${RESULT}
    exit 0
fi