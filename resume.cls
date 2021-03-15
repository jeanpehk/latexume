\LoadClass{article}
\ProvidesClass{resume}[Custom resume class]
\RequirePackage{titlesec}

% format section %
\titleformat{\section}
  {\Large\scshape\raggedright}
  {}{0em}
  {}
  [\titlerule]

% format subsection %
\titleformat{\subsection}
  {\large\scshape\raggedright}
  {}{0em}
  {}

\newcommand{\name}[1]{%
  \centerline{\Huge{#1}} \
}

\newcommand\contact[2] {
  \centerline{
    \makebox[0pt][c] {
      #1 {\large\textperiodcentered} #2
    }
  }
}

\newcommand{\subsec}[2]{
  \subsection[#1]{#1 \hfill #2}
}


