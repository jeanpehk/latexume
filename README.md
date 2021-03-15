# latexume

Generate a simple LaTeX resume from a subset of markdown.
For lazy minimalists like me who can't bother to actually learn LaTeX.

Can be used as is or as a base for further extension.

## Example

- Example of an input file in [examples/example.md](examples/example.md).
- Output as .tex in [examples/latexume.tex](examples/latexume.tex).
- Output as .pdf in [examples/latexume.pdf](examples/latexume.pdf).

## Build

This project uses stack.

```bash
$ stack build
```

## Generate LaTeX:

Generate file "generated/latexume.tex" from "resume.md":

```bash
$ stack exec latexume resume.md "inputfile.md" "Your Name" "email@mail.com" "otherOptional" "info"
```

Generate a pdf from .tex:
```bash
$ pdflatex generated/latexume.tex
```

## Commands

List of commands available.
Everything else you will need to provide with LaTeX.

### SECTION

A section definition includes a header and an optional amount of subsections.

Example:
```
# Experience

<SUBSECTION>

# Education

<SUBSECTION>

<SUBSECTION>

```

### SUBSECTION

A subsection definition includes a header, time information and content.

Example:
```
## MegaCorp101, Honolulu | <TIME>

Selling out since day one. Worked, slept, read. I did it all.

```

### TIME

Time information for a subsection.
Ending date is optional.

```
4/2019-3/2021
```

### ITALIC

starss

```
*blue skies*
```

### BOLD

more starsss

```
**water is warm**
```
