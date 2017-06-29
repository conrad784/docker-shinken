#!/bin/bash

RESULT=$(ps aux | grep $1 | grep -v grep)
if [ $? -ne 0 ]; then
    echo "$1 is down | status=2;1;2;0;2"
    echo "${RESULT}"
    exit 2
else
    echo "$1 is up | status=0;1;2;0;2"
    echo "${RESULT}"
    exit 0
fi