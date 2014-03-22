#!/bin/bash

SRC="$1"
DEST="$2"

cat "$SRC" |\
# Convert TeX accents to unicode chars. Pandoc would do this, but this
# way we can assume there is no } or \ within command arguments, and use
# captures such as [{]\([^}]\+\)[}].
sed -f sed_tex2uni |\
# Remove \index and \looseness lines.
sed '/^\\\(index\|looseness\)/d' |\
# Move chapter footnote after the chapter title, in a <p>.
sed -e '/\\chapterFootnote/,/\\chapter/{
    /\\chapterFootnote/{
        N;N;N;
        s/\\chapterFootnote[{]\([^\n]\+\)[}] *\n\(.*\)$/\n\2\n<p class="chapter-footnote" markdown="1">\1<\/p>\n/;
    };
}' |\
# Put dropcaps in <span>s.
sed 's_\\dropcaps[{]\([^}]\+\)[}][{]\([^}]\+\)[}]_<span class="dropcaps-first" markdown="1">\1</span><span class="dropcaps-words" markdown="1">\2</span>\&nbsp;_' |\
# Just italics for \pali and \qaitem.
sed 's/\\\(pali\|qaitem\)/\\textit/g' |\
# Swallow \gls and first argument (gls key), and leave the second argument (gls word).
sed 's/\\\(glsdisp\|glslink\)[{][^}]\+[}]//g' |\
# Add FIXME for labels to find and edit manually.
sed -e 's/\\label[{][^}]\+[}]//g; s/\\pageref[{][^}]\+[}]/FIXME:pageref/g' |\
pandoc --smart --normalize --from=latex --to=markdown |\
# Un-escape html tags.
sed 's/\\\([<>]\)/\1/g' |\
# Use kramdown-style \\ linebreaks.
sed 's/\([^\\]\)\\$/\1\\\\/' > "$DEST"

