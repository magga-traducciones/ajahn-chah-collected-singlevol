#!/bin/bash

SRC="$1"
DEST="$2"

cat "$SRC" |\
sed -f sed_tex2uni |\
sed '/^\\(index|looseness)/d' |\
sed -e '/\\chapterFootnote/,/\\chapter/{
    /\\chapterFootnote/{
        N;N;N;
        s/\\chapterFootnote[{]\([^\n]\+\)[}] *\n\(.*\)$/\n\2\n<p class="chapter-footnote">\1<\/p>\n/;
    };
}' |\
sed 's_\\dropcaps[{]\([^}]\+\)[}][{]\([^}]\+\)[}]_<span class="dropcaps-first">\1</span><span class="dropcaps-words">\2</span>_' |\
sed 's/\\(pali|qaitem)/\\textit/g' |\
sed 's/\\(glsdisp|glslink)[{][^}]\+[}]/\\textit/g' |\
sed -e 's/\\label[{][^}]\+[}]//g; s/\\pageref[{][^}]\+[}]/FIXME:pageref/g' |\
pandoc --smart --normalize --from=latex --to=markdown |\
sed 's/\([^\\]\)\\$/\1\\\\/' > "$DEST"

