#!/bin/bash

echo -n "" > palifreq

for i in ./*.tex
do
    cat $i | grep -vE '^\\index' |\
    sed 's/\\pali[{]/\n&/g' | grep -E '\\pali[{]' | tr "[:upper:]" "[:lower:]" | sed -f ../sed_tex2uni |\
    sed -e 's/\\glsdisp[{][^}]*[}]//g; s/\\glslink[{][^}]*[}]//g; s/[{][{]/{/g; s/[}][}]/}/g; s/[[:punct:]'"'"']\+[}]/}/g; s/[{]`/{/g;' |\
    sed 's/\\pali[{]\([^{}]\+\)[}].*/\1/' >> palifreq
done

cat palifreq | sort | uniq -c | sed 's/^ *//g' | sort -n > palifreq.tmp
mv palifreq.tmp palifreq

