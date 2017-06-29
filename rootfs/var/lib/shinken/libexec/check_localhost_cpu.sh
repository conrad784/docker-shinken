#!/bin/bash

CPU_WARN=$1
CPU_CRIT=$2

RESULT=$(top -n 1 | grep -E ^CPU: | awk '{print 100 - substr($8, 1, length($8)-1)}')

if [ $RESULT -gt $CPU_WARN ] && [ $RESULT -le $CPU_CRIT ] ; then
    echo "Usage : ${RESULT}% | status=${RESULT}%;${CPU_WARN};${CPU_CRIT};0;100"
    top -n 1 | grep -E ^CPU:
    exit 1
elif [ $RESULT -gt $CPU_CRIT ]; then
    echo "Usage : ${RESULT}% | status=${RESULT}%;${CPU_WARN};${CPU_CRIT};0;100"
    top -n 1 | grep -E ^CPU:
    exit 2
else
    echo "Usage : ${RESULT}% | status=${RESULT}%;${CPU_WARN};${CPU_CRIT};0;100"
    top -n 1 | grep -E ^CPU:
    exit 0
fi
