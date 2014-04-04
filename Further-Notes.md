
# Further Notes

## Requirements

For PDF:
- `lualatex`, (e.g. via TeXLive)
- fonts: Gentium, Gentium Book Basic, Arno Pro, GoudyOldStyTOT

For EPUB and MOBI:
- [prophecy][1] gem, v0.2.3 or later

Run `bundle` in the project folder to install gems.

Prophecy version `0.2.3` or later is necessary for the auto-generated
"Chapter Sixteen" style chapter headings. This is turned on in
`epub_mobi.yml` with:

    show_chapter_name: true
    chapter_number_format: word

[1]: https://github.com/profound-labs/prophecy

## Compilation

### PDF

    $ cd build/latex

If you only want to compile once, use:

    $ make pdf

If you want a more complete cycle, use:

    $ make

This takes a little while. It compiles the PDF, processes the indexes
and glossary, and compiles again twice. See `document` target in
`build/latex/Makefile`.

More than one `make` may be necessary for a final version. There are
various async features that require consecutive compilations: glossary
entries to include, index page numbers and other page references to
correct themselves.

It might need some extra `make glossaries` and `make pdf` until all the
async steps pull in the entries and complete the page references.

Preparing a final version would be best to abstract to a longer Makefile
target, this is what you do manually:

When preparing a final version, you can check that all steps are
completed by running `make`, renaming the resulting `book_main.pdf`,
running `make` again, and using `diffpdf` to see if the contents in the
PDF changed. If it did, repeat this, if it didn't, you are ready.

Also see `Tweaking` below.

### EPUB and MOBI

In the project folder:

    $ prophecy epub
    Running 'compass compile' ...
    unchanged sass/style-mobi-kf8.sass
    unchanged sass/style-epub.sass
    unchanged sass/style-mobi.sass
    OK
    Cleaning ./build/epub ...
    Delete everything in ./build/epub ? [yN]

Answer `y`, the `build/epub` folder is meant to be re-built as often as
needed (like the rendered html of a static website). The compiled epub
will be in the `publish/epub` folder.

Validate the epub:

    $ prophecy epub_check publish/epub/the-book.epub

When satisfied with the new epub, copy the finished file to
`publish/final` folder and commit it.

Also commit the changes in the sources and the generated `build/epub`.

The process is similar when you run `prophecy mobi`. The mobi will be
converted from an epub file with `kindlegen` and `kindlestrip`.

## Tweaking

Some ways of correcting widows, orphans, or overfull lines.

To encourage a hyphenation break at a particular place, use
`Im\-agination`.

To stop a word from hyphenating, wrap it in `\mbox{Imagination}`.

To keep multiple words on the same line: `\mbox{only this}`, or use a
non-breaking space: `only~this`.

Force linebreaks with `\linebreak`, not `\\`. Don't forget a tracing
`\ ` or `{}`, otherwise the space will be gobbled:

    manifesting in vastly\linebreak\ different forms

You can encourage `TeX` to try to keep a paragraph in less lines with
`\looseness=-1`. This only works if the paragraph is possible to
tighten, i.e. if there are only a few words spilling over.

    \looseness=-1
    Well, just as it was getting dark I had my chance, in they came carrying
    a corpse. Just my luck! I couldn't even feel my feet touch the ground, I
    wanted to get out of there so badly.

### Glossary

To tweak the glossary output in the above ways, rename the auto-generated
`book_main.gls` to `book_main.manual-gls`, and make edits to that file.

If `book_main.manual-gls` exists, the `make_glossaries.sh` script will
use that to overwrite the auto-generated `.gls`.

## Known Issues

The first published version of the book (started in 2009) was compiled
with `pdflatex` and the `book` class. The upgrade to `lualatex` and the
`memoir`-based `anecdote` class results in some overfull lines and other
slight changes.

This is fine for the "Web version", but it will need review before a
press publication. The `draft` documentclass option will mark overfull
lines with a black rectangle for easy spotting.

