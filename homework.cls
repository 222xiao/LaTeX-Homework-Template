\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2026/09/21 General bilingual homework template]
\newif\ifhomeworkchinese
\homeworkchinesetrue
\DeclareOption{chinese}{\homeworkchinesetrue}
\DeclareOption{english}{\homeworkchinesefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\RequirePackage{iftex}
\ifXeTeX\else
  \ClassError{homework}{XeLaTeX is required}{Select XeLaTeX in your editor.}
  \expandafter\endinput
\fi
% Bundled TrueType Chinese fonts embed explicit Unicode maps for PDF viewers.
\ifhomeworkchinese
  \LoadClass[UTF8,a4paper,11pt,oneside,fontset=none]{ctexart}
\else
  \LoadClass[UTF8,a4paper,11pt,oneside,fontset=none,scheme=plain]{ctexart}
\fi
\setCJKmainfont{NotoSerifSC-Regular.ttf}[Path=fonts/,
  BoldFont=NotoSerifSC-Bold.ttf,ItalicFont=NotoSerifSC-Regular.ttf,
  BoldItalicFont=NotoSerifSC-Bold.ttf,ItalicFeatures={FakeSlant=0.15},
  BoldItalicFeatures={FakeSlant=0.15}]
\setCJKsansfont{NotoSerifSC-Regular.ttf}[Path=fonts/,BoldFont=NotoSerifSC-Bold.ttf]
\setCJKmonofont{NotoSerifSC-Regular.ttf}[Path=fonts/,BoldFont=NotoSerifSC-Bold.ttf]
% Keep LaTeX's default Latin fonts. Unlike loading TeX Gyre by filename,
% this works consistently in TeX Live, MiKTeX, Overleaf, and Tectonic.
\RequirePackage[margin=25mm,headheight=28pt,headsep=6mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage[normalem]{ulem}
\RequirePackage{amsmath,amssymb}
\RequirePackage{booktabs,tabularx,array}
\RequirePackage{enumitem}
\RequirePackage{setspace}
\RequirePackage{needspace}
\RequirePackage{placeins}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{keyval}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{hyperref}
\definecolor{homeworkblue}{HTML}{244A64}
\hypersetup{colorlinks=true,linkcolor=homeworkblue,citecolor=homeworkblue,
  urlcolor=homeworkblue,bookmarksnumbered=true,unicode=true}
\urlstyle{same}
\setstretch{1.25}
\setlength{\parskip}{0.35em}
\setlist{itemsep=0.2em,topsep=0.4em}
\emergencystretch=2em
\newcommand{\hwtext}[2]{\ifhomeworkchinese#1\else#2\fi}
\ifhomeworkchinese
  \renewcommand{\contentsname}{目录}
  \renewcommand{\refname}{参考文献}
\else
  \renewcommand{\contentsname}{Contents}
  \renewcommand{\refname}{References}
  \renewcommand{\figurename}{Figure}
  \renewcommand{\tablename}{Table}
  \renewcommand{\abstractname}{Abstract}
  \renewcommand{\today}{\number\year-\ifnum\month<10 0\fi\number\month-\ifnum\day<10 0\fi\number\day}
\fi
% Personal/course information is supplied through \homeworksetup.
\def\hw@title{\hwtext{课程作业}{Course Homework}}
\def\hw@assignment{\hwtext{课程作业}{Course Homework}}
\def\hw@examplenote{}
\def\hw@shorttitle{\hwtext{课程作业}{Course Homework}}
\def\hw@university{}
\def\hw@department{}
\def\hw@course{}
\def\hw@coursecode{}
\def\hw@author{}
\def\hw@studentid{}
\def\hw@instructor{}
\def\hw@date{\today}
\def\hw@logo{}
\define@key{homework}{assignment}{\def\hw@assignment{#1}}
\define@key{homework}{example-note}{\def\hw@examplenote{#1}}
\define@key{homework}{title}{\def\hw@title{#1}}
\define@key{homework}{short-title}{\def\hw@shorttitle{#1}}
\define@key{homework}{university}{\def\hw@university{#1}}
\define@key{homework}{department}{\def\hw@department{#1}}
\define@key{homework}{course}{\def\hw@course{#1}}
\define@key{homework}{course-code}{\def\hw@coursecode{#1}}
\define@key{homework}{author}{\def\hw@author{#1}}
\define@key{homework}{student-id}{\def\hw@studentid{#1}}
\define@key{homework}{instructor}{\def\hw@instructor{#1}}
\define@key{homework}{date}{\def\hw@date{#1}}
\define@key{homework}{logo}{\def\hw@logo{#1}}
\newcommand{\homeworksetup}[1]{\setkeys{homework}{#1}}
\newif\ifhomeworkcover
\homeworkcovertrue
\newif\ifhomeworktoc
\homeworktocfalse
\newcommand{\hw@row}[2]{\ifx#2\@empty\else#1 & #2\\[0.4em]\fi}
\newif\ifhw@hasmetadata
\newcommand{\hw@metadata}{%
  \hw@hasmetadatafalse
  \ifx\hw@course\@empty\else\hw@hasmetadatatrue\fi
  \ifx\hw@coursecode\@empty\else\hw@hasmetadatatrue\fi
  \ifx\hw@author\@empty\else\hw@hasmetadatatrue\fi
  \ifx\hw@studentid\@empty\else\hw@hasmetadatatrue\fi
  \ifx\hw@instructor\@empty\else\hw@hasmetadatatrue\fi
  \ifx\hw@date\@empty\else\hw@hasmetadatatrue\fi
  \ifhw@hasmetadata
  \begin{tabularx}{0.9\linewidth}{@{}>{\bfseries}p{0.25\linewidth}X@{}}
    \hw@row{\hwtext{课程}{Course}}{\hw@course}
    \hw@row{\hwtext{课程代码}{Course code}}{\hw@coursecode}
    \hw@row{\hwtext{姓名}{Name}}{\hw@author}
    \hw@row{\hwtext{学号}{Student ID}}{\hw@studentid}
    \hw@row{\hwtext{授课教师}{Instructor}}{\hw@instructor}
    \hw@row{\hwtext{提交日期}{Date}}{\hw@date}
  \end{tabularx}%
  \fi}
\newcommand{\hw@branding}{%
  \ifx\hw@logo\@empty\else
    \IfFileExists{\hw@logo}{%
      \includegraphics[width=0.65\linewidth,height=25mm,keepaspectratio]{\hw@logo}\par\medskip
    }{\ClassWarning{homework}{Logo file '\hw@logo' not found; skipping logo}}%
  \fi
  \ifx\hw@university\@empty\else{\Large\bfseries\hw@university\par}\fi
  \ifx\hw@department\@empty\else{\normalsize\hw@department\par}\fi}
\newcommand{\makehomeworktitle}{%
  \hypersetup{pdftitle={\hw@title},pdfauthor={\hw@author}}%
  \ifhomeworkcover
    \hypersetup{pageanchor=false}% The cover and first content page both use counter 1.
    \newgeometry{top=20mm,bottom=20mm,left=15mm,right=15mm}
    \begin{titlepage}
      \centering
      \setstretch{1}
      \setlength{\parskip}{0pt}
      \vspace*{3mm}
      \ifx\hw@logo\@empty\else
        \IfFileExists{\hw@logo}{%
          \includegraphics[width=\linewidth,height=52mm,keepaspectratio]{\hw@logo}\par
          \vspace{11mm}
        }{\ClassWarning{homework}{Logo file '\hw@logo' not found; skipping logo}}%
      \fi
      {\fontsize{22}{27}\selectfont\bfseries
        \hw@coursecode
        \ifx\hw@coursecode\@empty\else
          \ifx\hw@course\@empty\else\enspace$|$\enspace\fi
        \fi
        \hw@course\par}
      \vspace{18mm}
      {\fontsize{20}{25}\selectfont\bfseries\hw@assignment\par}
      \vspace{25mm}
      {\fontsize{22}{28}\selectfont\itshape\uline{\hw@title}\par}
      \vfill
      {\fontsize{16}{21}\selectfont\bfseries
        \begin{tabular}{c}
          \hline\\[-1.2ex]
          \ifx\hw@author\@empty\else\hw@author\\\fi
          \ifx\hw@studentid\@empty\else
            {\normalfont\small\hwtext{学号：}{Student ID: }\hw@studentid}\\\fi
          \ifx\hw@department\@empty\else\hw@department\\\fi
          \ifx\hw@university\@empty\else\hw@university\\\fi
          \ifx\hw@instructor\@empty\else
            {\normalfont\small\hwtext{授课教师：}{Instructor: }\hw@instructor}\\\fi
          \hline
        \end{tabular}\par}
      \vspace{12mm}
      {\large\hw@date\par}
      \ifx\hw@examplenote\@empty\else
        \vspace{5mm}
        {\footnotesize\hw@examplenote\par}
      \fi
    \end{titlepage}
    \restoregeometry
    \hypersetup{pageanchor=true}% Restore anchors after the cover has shipped out.
  \else
    \begin{center}
      \hw@branding\medskip
      {\LARGE\bfseries\color{homeworkblue}\hw@title\par}\medskip
      \hw@metadata
      \ifx\hw@examplenote\@empty\else\par\smallskip{\footnotesize\hw@examplenote\par}\fi
    \end{center}
    \medskip
  \fi}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\nouppercase{\hw@shorttitle}}
\fancyhead[R]{\small\hw@author}
\fancyfoot[C]{\small\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\small\thepage}\renewcommand{\headrulewidth}{0pt}}
% A problem is a numbered section; labels and the optional TOC work normally.
\newcommand{\problem}[1]{\Needspace{6\baselineskip}\section{#1}}
\newenvironment{solution}{\par\medskip\noindent\textbf{\hwtext{解答}{Solution}}\par\nobreak}{\par\medskip}
\bibliographystyle{unsrtnat}
\endinput
