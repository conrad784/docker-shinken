#!/bin/bash

MEM_WARN=$1
MEM_CRIT=$2

MEM_FREE=$(free | grep Mem: | awk '{print (($2 - $4 - $5 -$6 - $7)*100/$2)}' | cut -d. -f1)

if [ $MEM_FREE -gt $MEM_WARN ] && [ $MEM_FREE -le $MEM_CRIT ]; then
    echo "Usage : ${MEM_FREE}% | status=${MEM_FREE}%;${MEM_WARN};${MEM_CRIT};0;100"
    free
    exit 1
elif [ $MEM_FREE -gt $MEM_CRIT ]; then
    echo "Usage : ${MEM_FREE}% | status=${MEM_FREE}%;${MEM_WARN};${MEM_CRIT};0;100"
    free
    exit 2
else
    echo "Usage : ${MEM_FREE}% | status=${MEM_FREE}%;${MEM_WARN};${MEM_CRIT};0;100"
    free
    exit 0
fi