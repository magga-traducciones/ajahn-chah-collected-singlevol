#!/bin/bash

# $1: index name (general / similes)
# $2: style

outputlog="buildvol.log"
touch $outputlog

echo_stars () {
    echo "***********************************************************************";
}

echo_stars >> $outputlog
if [ "$2" != "" ]; then
    style=$2
else
    style=$1
fi

echo -n "xindy $1 style-$style... " | tee $outputlog

# Check if there is a manually manipulated .ind file that we should use.
if [ -e "$1-manual.ind" ]; then
    echo "SKIP, found manual index file: $1-manual.ind" | tee $outputlog
    echo "COPY $1-manual.ind TO $1.ind" | tee $outputlog
    cp $1-manual.ind $1.ind | tee $outputlog
    return 0
fi

echo "xindy -I latex -o $1.ind -M style-$style $1.idx >> $outputlog 2>&1" >> $outputlog
xindy -I latex -o $1.ind -M style-$style $1.idx >> $outputlog 2>&1
#~ grep -iE 'error|warning'
echo $?
echo_stars >> $outputlog

