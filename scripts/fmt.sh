#!/bin/sh

# flutter dartfmt -l 120 -n --set-exit-if-changed lib

res=`flutter dartfmt -l 120 --set-exit-if-changed . | grep 'Formatted'`

echo ">>>>>>>>> $res"

if [[ $res == "" ]]; then
    echo "empty"
    exit 0
else
    echo "not empty"
    exit 1
fi

# # exit 1