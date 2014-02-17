% Opus Class
%
% A memoir-based documentclass for books with a classical or somber content.
%
% https://github.com/profound-labs/opus
%
% http://profound-labs.github.io/projects/opus/
%
% (c) Gambhiro Bhikkhu, 2013
% gambhiro@ratanagiri.org.uk
%
% LPPL LaTeX Pubic Project Licence
%

% ==============
% Identification
% ==============

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{opus}[2014/02/12 v0.5 A document class for books with a classical or somber content.]

% ========================
% Preliminary Declarations
% ========================

% =======
% Options
% =======

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /BOOK/.cd,
  pagePreset/.default=largepage,% "largepage": 6x9in, "smallpage": 5.25x8in
  pagePreset/.store in=\BOOK@pagePreset,
  babelLanguage/.default=british,
  babelLanguage/.store in=\BOOK@babelLanguage,
}

% Pass all unknown options to memoir
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessPgfOptions{/BOOK}
\ProcessOptions\relax

% ======================
% All Other Declarations
% ======================

\LoadClass[11pt,twoside]{memoir}

\RequirePackage{book-core-first}

% === Page geometry and layout ===

% Symbols used:
% P = page proportion (h/w)
% T = textblock proportion (d/m)
% w = paper width
% h = paper height
% m = text width
% d = text height

\ifthenelse{\equal{\BOOK@pagePreset}{largepage}}{

  % Large page size
  %
  % 6in x 9in page
  % P = 1.5 (fifth)
  % T = 1.539 (Pentagon, between fifth and minor 6th)

  % For 10.5pt / 15pt font size, Gentium font, 20pt parindent, no
  % parskip. The textblock is a somber proportion (Pentagon 1:1.539),
  % ~70 characters wide. The slightly open linespacing aviods wall of
  % text effect. The inner margins keep the text out from the spine,
  % so a large book doesn't have to be strained to read the words
  % toward the center. Running header on top with title and chapter
  % marks, centered. Page number centered in footer, about three
  % linespace from text, bottom margin taller than top margin. This
  % gives the textblock a slightly elevated atmosphere, but with a
  % low-resonance proportion (between fifth and minor 6th musical
  % scale) for long prose (Dhamma talks), instead of a high-resonance
  % narrower column that would suit lighter text.

  % === normalsize ===

  \renewcommand{\normalsize}{%
    \@setfontsize\normalsize{10.5}{15}
    \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
    \abovedisplayshortskip \z@ \@plus3\p@
    \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
    \belowdisplayskip \abovedisplayskip
    \color{textbody}
    \let\@listi\@listI}
  \normalsize

  % === indentations ===

  \setlength{\vgap}{1.5em}
  \setlength{\vindent}{\vgap}
  \setlength{\vleftmargin}{2em}

  \setlength{\parskip}{5pt}
  \setlength{\parindent}{20pt}

  % === setup page layout ===

  \setstocksize{9in}{6in}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
  % no parskip, so exactly 33 lines
  %   = 490.5pt
  %   = 172.39mm
  %   = 32\baselineskip + \topskip
  % 1/1.539 = 0.649 (Pentagon) ratio to height, 112mm
  \settypeblocksize{32\baselineskip + \topskip}{*}{0.649}% 1/1.539, Tall Pentagon
  % alt: Short Pentagon, 1.376
  \setlrmargins{*}{*}{1.333}% fourth 3:4, 23.15mm | 17.3mm
  \setulmargins{*}{*}{1.778}% minor 7th 9:16, 20.23mm | 35.97mm
  \setheaderspaces{*}{4mm}{*}% ~ 1/Golden section, closer to text
  \setlength{\footskip}{3\baselineskip}
  \checkandfixthelayout

}{
\ifthenelse{\equal{\BOOK@pagePreset}{smallpage}}{

  % Small page size
  %
  % 5.25in x 8in page
  % P = 1.523 (~Pentagon (1.539), b/w fifth (1.5) and minor 6th (1.6))
  % T = 1.618 (Golden Section, ~minor 6th (1.6))

  % For 10.5pt / 15pt font size, 27 lines, Gentium font, no parskip, 17pt parindent.

  % === normalsize ===

  \renewcommand{\normalsize}{%
    \@setfontsize\normalsize{10.5}{15}
    \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
    \abovedisplayshortskip \z@ \@plus3\p@
    \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
    \belowdisplayskip \abovedisplayskip
    \color{textbody}
    \let\@listi\@listI}
  \normalsize

  % === indentations ===

  \setlength{\vgap}{1.5em}
  \setlength{\vindent}{\vgap}
  \setlength{\vleftmargin}{2em}

  % === setup page layout ===

  \setlength{\parskip}{0pt}
  \setlength{\parindent}{17pt}

  \setstocksize{8in}{5.25in}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
  \settypeblocksize{27\baselineskip + \topskip}{*}{0.618}% 1/1.618 Golden section
  \setlrmargins{*}{*}{0.889}% major 2nd 15:16
  \setulmargins{*}{*}{1.701}% Tall Pentagon
  \setlength{\footskip}{3\baselineskip}
  \checkandfixthelayout

}{
\ifthenelse{\equal{\BOOK@pagePreset}{largevolume}}{

  % Large Volume page size
  %
  % 6in x 9in page
  % P = 1.5 (fifth)
  % T = 1.568181

  % TODO: elaborate on style.

  % === normalsize ===

  \renewcommand{\normalsize}{%
    \@setfontsize\normalsize{10.5}{15}
    \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
    \abovedisplayshortskip \z@ \@plus3\p@
    \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
    \belowdisplayskip \abovedisplayskip
    \color{textbody}
    \let\@listi\@listI}
  \normalsize

  % === indentations ===

  \setlength{\vgap}{1.5em}
  \setlength{\vindent}{\vgap}
  \setlength{\vleftmargin}{2em}

  \setlength{\parskip}{0pt}
  \setlength{\parindent}{15pt}

  % === setup page layout ===

  \setstocksize{9in}{6in}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}

  % textheight: 177.8mm (7in) - 15pt (\baselineskip) = 172.5mm
  % or 32.5999 lines
  % textwidth: 110mm
  % 1/1.568181 = 0.63768 ratio

  % no parskip, so 32.5 lines
  %   = 487.5pt
  %   = 171.97917mm
  %   = 31.5\baselineskip + \topskip
  \settypeblocksize{31.5\baselineskip + \topskip}{110mm}{*}
  \setlrmargins{*}{15mm}{*}% 27.4mm | 15mm
  \setulmargins{26mm}{*}{*}
  \setheaderspaces{*}{13mm}{*}
  \setlength{\footskip}{3\baselineskip}
  \checkandfixthelayout

}{

  % other page sizes?

}}}

% alias the pagestyles into semantic names, "where it is used"

\aliaspagestyle{normalpage}{topbottomcentered}

\RequirePackage{book-core-last}

