#!/bin/bash

for i in ../manuscript/tex/*.tex
do
    echo `basename "$i"`"... "
    d="../manuscript/markdown/"`basename "$i"`
    d=$(echo -n "$d" | sed 's/\.tex$/.md/')
    if [ -e "$d" ]; then
        cp --backup=numbered $d $d.bak
    fi

    ./tex2md.sh "$i" "$d" \
        && ./check-converted.sh "$d"
done

