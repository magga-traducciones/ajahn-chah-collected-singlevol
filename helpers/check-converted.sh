#!/bin/bash

c=$(grep -cE '\\[a-zA-Z]' "$1")
if [ ! $c -eq 0 ]; then
    echo "WARNING! Remaining commands on $c lines"
    grep -nE '\\[a-zA-Z]' "$1" | sed -e 's/^/    /; s/$/\n/'
    echo ""
fi

c=$(grep -cE '[{}]' "$1")
if [ ! $c -eq 0 ]; then
    echo "WARNING! Remaining braces on $c lines"
    grep -nE '[{}]' "$1" | sed -e 's/^/    /; s/$/\n/'
    echo ""
fi

c=$(grep -cE 'FIXME|TODO' "$1")
if [ ! $c -eq 0 ]; then
    echo "WARNING! Remaining FIXME or TODO on $c lines"
    grep -nE 'FIXME|TODO' "$1" | sed -e 's/^/    /; s/$/\n/'
    echo ""
fi

chars="~%"
c=$(grep -cE '['$chars']' "$1")
if [ ! $c -eq 0 ]; then
    echo "* WARNING! Remaining $chars on $c lines"
    grep -nE '['$chars']' "$1" | sed -e 's/^/    /; s/$/\n/'
    echo ""
fi

