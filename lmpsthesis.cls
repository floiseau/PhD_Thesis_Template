% ------------------------------------------------------------------------
% Title: Class file for LMPS-themed thesis template
% Authors:
%   - Flavien Loiseau (flavien.loiseau@ens-paris-saclay.fr),
%   - Alexandre Daby-Seesaram (alexandre.daby-seesaram@ens-paris-saclay.fr)
% Last update: 21/12/2023
% ------------------------------------------------------------------------

%-------%
% Class %
%-------%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lmpsthesis}[16/12/2023 Class for PhD Thesis at LMPS]

%---------%
% Options %
%---------%
% Descriptions
%   - emptypage: make the pages with no content empty (completly blank)
%   - french: load babel in french
%   - tikz: load tikz (and externalization), it is recommended to name the tikzpicture using \tikzsetnextfilename
%   - all other options are passed to the book class
% Empty page
\newif\if@loademptypage %\@loademptypagefalse
\DeclareOption{emptypage}{\@loademptypagetrue}
% French
\newif\if@loadfrench %\@loadfrenchfalse
\DeclareOption{french}{\@loadfrenchtrue}
% Tikz
\newif\if@loadtikz %\@loadtikzfalse
\DeclareOption{tikz}{\@loadtikztrue}
% Pass all other options to book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
% Process options
\ProcessOptions\relax

%-------------------%
% Options treatment %
%-------------------%
% Emptypage
\if@loademptypage
  \RequirePackage{emptypage}
\fi
% French
\if@loadfrench
  \RequirePackage[french]{babel}
\fi
% Tikz
% see in the Tikz section

%-------%
% Class %
%-------%
\LoadClass{book}

%----------%
% Packages %
%----------%
%%% Encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

%%% Font
\RequirePackage{fourier}
\renewcommand{\baselinestretch}{1.1} % Increase the base line spacing

%%% Colors
% Package
\RequirePackage{xcolor}
% Define colors
\definecolor{accentcolor}{RGB}{25,40,85} % FLAVOR Change accent color if you want
\definecolor{lmpsblue}{RGB}{25,40,85}
\definecolor{lmpsgrey}{RGB}{130,130,130}
\definecolor{toolred}{RGB}{255,70,60}
\definecolor{toolorange}{RGB}{255,160,40}
\definecolor{toolrose}{RGB}{255,60,255}
\definecolor{toolblue}{RGB}{100,140,255}
\definecolor{toolgreen}{RGB}{0,200,140}
\definecolor{toolviolet}{RGB}{130,30,255}

%%% Geometry
% Geometry
\RequirePackage[
    % showframe,
    left=1in,     % left margin
    right=1in,    % right margin
    top=1in,      % top margin
    headheight=19pt,
    headsep=0.42in,
    bottom=1in,    % bottom margin
    footskip=0.6in,
    ]{geometry}
% Better justification
\RequirePackage{microtype}

%%% Figures
% Figures
\RequirePackage{graphicx}
% Include PDF (for title page)
\usepackage{pdfpages}
% Captions (https://latex-tutorial.com/caption-customization-latex/)
\usepackage[hang,labelfont={bf,color=accentcolor}]{caption}
\DeclareCaptionLabelSeparator{bullet}{~$\bullet$~}
\captionsetup{labelsep=bullet}
% Figure after the first reference
\RequirePackage{flafter}

%%% Tikz
\if@loadtikz
    % Tikz (and externalization (in a subdir of build))
    \RequirePackage{tikz}
    % PGFPlots
    \RequirePackage{pgfplots}
    \pgfplotsset{compat=newest}
    % Externalization of tikz figures (https://tex.stackexchange.com/a/360284)
    \usepgfplotslibrary{external}
    \usetikzlibrary{pgfplots.external}
    \tikzexternalize[prefix=build/,optimize command away=\includepdf]
\fi

%%% Headers and footers
\RequirePackage{fancyhdr}
% Height of the bands
\newlength{\bandh}\setlength{\bandh}{1.2em}
% Fancy style (most page)
\fancypagestyle{fancy}{
    \fancyhf{}
    % Adjust the offset of the header content
    \fancyheadoffset[LR]{1in}
    % Adjust the offset of the footer content
    \fancyfootoffset[LR]{1in}
    % Alternating left/right page number
    \fancyfoot[LE]{\colorbox{accentcolor}{\textcolor{white}{\parbox[c][\bandh]{0.92in}{\hfill\bfseries\thepage\hfill\null}}}}
    \fancyfoot[RO]{\colorbox{accentcolor}{\textcolor{white}{\parbox[c][\bandh]{0.92in}{\hfill\bfseries\thepage\hfill\null}}}}
    % Even pages  left: Chapter title
    \fancyhead[LE]{\colorbox{accentcolor!10}{\textcolor{accentcolor}{\parbox[c][\bandh]{\textwidth+0.92in}{\hspace{0.92in}\bfseries\nouppercase\leftmark\hfill\null}}}}
    % Odd  pages right: Section title
    \fancyhead[RO]{\colorbox{accentcolor!10}{\textcolor{accentcolor}{\parbox[c][\bandh]{\textwidth+0.92in}{\hfill\bfseries\nouppercase\rightmark\hspace{0.92in}\null}}}}
}
% Headers and footers in plain style (frontmatter, chapter pages, ...)
\fancypagestyle{plain}{
    \fancyhf{}
    % Remove header line
    \renewcommand{\headrulewidth}{0pt}
    % Remove header
    \fancyhead{}
    % Adjust the offset of the header content
    \fancyheadoffset[LR]{1in}
    % Adjust the offset of the footer content
    \fancyfootoffset[LR]{1in}
    % Alternating left/right page number
    \fancyfoot[LE]{\colorbox{accentcolor}{\textcolor{white}{\parbox[c][\bandh]{0.92in}{\hfill\bfseries\thepage\hfill\null}}}}
    \fancyfoot[RO]{\colorbox{accentcolor}{\textcolor{white}{\parbox[c][\bandh]{0.92in}{\hfill\bfseries\thepage\hfill\null}}}}
}
% Choose header and footer for frontmatter
\let\oldfrontmatter\frontmatter
\gdef\frontmatter{\oldfrontmatter\pagestyle{plain}}
% Choose header and footer for mainmatter
\let\oldmainmatter\mainmatter
\gdef\mainmatter{\oldmainmatter\pagestyle{fancy}}

%%% Title styles
\RequirePackage{titlesec}
% Part style
\makeatletter
\titleformat{\part}[display]
  {\Huge}
  {\vspace{-60pt}\colorbox{accentcolor!10}{\parbox[c][\bandh]{\dimexpr \linewidth+1in \relax}{\raisebox{+0.1em}[\bandh][+0.1em]{\hspace{1em}\textcolor{accentcolor}{\scalebox{3.2}{\partname}\scalebox{4}{~\thepart}}}}}}
  {30pt}
  {\filleft\bfseries\fontsize{28}{32}\selectfont\textcolor{accentcolor}}
\makeatother
% Chapter style
\titleformat{\chapter}[display]% Numbered
  {\huge}
  {\colorbox{accentcolor!10}{\parbox[c][\bandh]{\dimexpr \linewidth+1in \relax}{\raisebox{+0.1em}[\bandh][+0.1em]{\hspace{1em}\textcolor{accentcolor}{\scalebox{4}{\thechapter}}}}}} % FLAVOR - Without "chapter" in title and number in classic font
  % {\colorbox{accentcolor!10}{\parbox[c][\bandh]{\linewidth+1in}{\raisebox{+0.072em}[\bandh][+0.072em]{\hspace{0em}\textcolor{accentcolor}{{\normalfont\Large\chaptername}~~\scalebox{4}{\usefont{OT1}{ptm}{m}{n}\selectfont\thechapter}}}}}} % FLAVOR - With "chapter" in title and number in PTM font
  {1em}
  {\normalfont\huge\textcolor{accentcolor}}
% Section style
\renewcommand{\thesection}{\arabic{section}} % Remove chapter number in section numbers
\titleformat{\section}
   {\normalfont\Large\bfseries}
   {\colorbox{accentcolor!10}{\raisebox{0.0em}[0.2ex][0.1ex]{\textcolor{accentcolor}{\thesection}}\hspace{0.5em}}}
   {1em}
   {\hspace{-0.5em}\textcolor{accentcolor}}
% Subsection style
\titleformat{\subsection}
   {\normalfont\large\bfseries}
   {\colorbox{accentcolor!10}{\raisebox{0.0em}[0.1ex][0.05ex]{\textcolor{accentcolor}{\thesubsection}}\hspace{0.5em}}}
   {1em}
   {\hspace{-0.5em}\textcolor{accentcolor}}
% Subsubsection style
\titleformat{\subsubsection}{\normalfont\normalsize\bfseries\color{accentcolor}}{\thesubsubsection}{1em}{}
% Paragraph style
\titleformat{\paragraph}[runin]{\normalfont\normalsize\bfseries\color{accentcolor}}{\theparagraph}{1em}{}
% Add period after paragraph title
\let\oldparagraph=\paragraph
\renewcommand\paragraph[1]{\oldparagraph{#1.}}

%%% Bibliography
% Biblatex
\RequirePackage[bibstyle=custom-apa,labeldate=year,citestyle=apa,isbn=false,url=false,eprint=false,backref=true,sortcites=false,sorting=nyt,uniquename=false,uniquelist=false,maxcitenames=2]{biblatex}
% Increase the line spacing in the bibliography
\setlength\bibitemsep{1.5\itemsep}

%%% Links
% Hyperref
\usepackage[hypertexnames=true,bookmarksnumbered]{hyperref}
\Urlmuskip=0mu plus 1mu % Fix to split url in the biblio (https://tex.stackexchange.com/a/115820)
% Bookmark
\usepackage{bookmark} % Fix to set conclusion outside of the last part
% Link color
\hypersetup{colorlinks,citecolor=accentcolor!80,linkcolor=accentcolor!80,urlcolor=accentcolor!80,linktoc=all}

%%% Notations
\usepackage{longtable}

%%% Minitoc
\RequirePackage{minitoc}
% \nomtcrule                                                                         % FLAVOR Remove minitoc rules
% \mtcsetformat{minitoc}{dotinterval}{2}
\renewcommand{\mtctitle}{\textcolor{accentcolor}{Contents}}                        % Add color to minitoc title
\renewcommand{\mtcfont}{\small\rmfamily\upshape\mdseries\color{accentcolor!80}}    % Change color of    section in minitoc
\renewcommand{\mtcSfont}{\small\rmfamily\upshape\bfseries\color{accentcolor!80}}   % Change color of subsection in minitoc
\dominitoc

%%% Epigraph
\RequirePackage{epigraph}

%%% Custom commands
% Introduction
\newcommand{\thesisintroduction}[1]{%
    \chapter*{#1}
    \label{cha:introduction}
    %
    \addcontentsline{toc}{chapter}{Introduction}    % Add introduction to TOC
    \mtcaddchapter                                  % Fix enabling minitoc to show correctly
    \markboth{Introduction}{}                       % Set headers (https://tex.stackexchange.com/questions/426537/wrong-header-in-unnumbered-chapter)
}
% Conclusion
\newcommand{\thesisconclusion}[1]{%
    \bookmarksetup{startatroot}                 % Fix to show the conclusion outside of previous part in PDF reader outline (https://tex.stackexchange.com/questions/12542/is-it-possible-to-add-chapter-after-a-few-parts-at-the-same-level-of-hierarch)
    \chapter*{#1}
    \label{cha:conclusion}
    %
    \addcontentsline{toc}{chapter}{Conclusion}  % Add conclusion to TOC
    \mtcaddchapter                              % Fix enabling minitoc to show correctly
    \markboth{Conclusion}{}                     % Set headers (https://tex.stackexchange.com/questions/426537/wrong-header-in-unnumbered-chapter)
    \setcounter{section}{0}                     % Increment the section counter to reset the section numbers in unumbered chapter (https://tex.stackexchange.com/questions/163492/restart-section-numbering-after-unnumbered-chapter)
}
% Appendix
\newcommand{\thesisappendix}{
    \appendix
    \part*{\appendixname}
    \renewcommand\chaptername{Appendix}
    \renewcommand{\thechapter}{\Alph{chapter}}
}

%%% Custom environments
% Chapter abstract
\newenvironment{chapabstract}{\itshape\color{accentcolor}}{\\[2em]}
