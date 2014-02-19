#!/bin/bash

echo -n "makeglossaries... "

# Check if there is a manually manipulated -gls file that we should use.
if [ -e "book_main.manual-gls" ]; then
    echo "SKIP, found manual glossary file: book_main.manual-gls"
    echo "COPY book_main.manual-gls TO book_main.gls"
    cp book_main.manual-gls book_main.gls
    exit 0
fi

makeglossaries book_main > /dev/null 2>&1

if [ "$?" == "0" ]; then
    echo -n "OK, "
else
    echo -n "exit $?, "
fi

echo $(grep -cE '\\glossaryentryfield' book_main.gls)" entries"

