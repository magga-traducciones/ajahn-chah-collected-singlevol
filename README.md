
# The Collected Teachings of Ajahn Chah

**Single Volume Compilation**

Paperback status: **COMPLETED**  
Ebook status: **COMPLETED**

ISBN for paperback: `978-0-9568113-8-7`

ISBN for ebooks: `978-1-908444-12-7`

Find the final PDF, EPUB and MOBI files in `publish/final/` folder.

# Requirements

For PDF:
- `lualatex`, (e.g. via TeXLive)
- fonts: Gentium, Gentium Book Basic, Arno Pro, GoudyOldStyTOT

For EPUB and MOBI:
- `prophecy` gem, v0.2.3 or later

Install [prophecy][1] with `gem install prophecy` or run `bundle` in the
project folder. Version `0.2.3` or later is necessary for the
auto-generated "Chapter Sixteen" style chapter headings. This is turned
on in `epub_mobi.yml` with:

    show_chapter_name: true
    chapter_number_format: word

[1]: https://github.com/profound-labs/prophecy

# Compilation

## PDF

    $ cd build/latex

If you only want to compile once, use:

    $ make pdf

If you want a more complete cycle, use:

    $ make

This takes a little while. It compiles the PDF, processes the indexes
and glossary, and compiles again.

It might need some extra `make glossaries` and `make pdf` until all the
async steps pull in the entries and complete the linked references.

## EPUB and MOBI

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

# Known Issues

The first published version of the book (started in 2009) was compiled
with `pdflatex` and the `book` class. The upgrade to `lualatex` and the
`memoir`-based `anecdote` class results in some overfull lines and other
slight changes.

This is fine for the "Web version", but it will need review before a
press publication. The `draft` documentclass option will mark overfull
lines with a black rectangle for easy spotting.

# Changelog

2014-04-03
- all-around big maintenance update
- ported to `anecdote` documentclass
- ebooks with `prophecy` gem

