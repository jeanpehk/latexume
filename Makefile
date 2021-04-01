.PHONY: all example clean

name = latexume

all:
	pdflatex generated/$(name).tex

# Generate an example
example:
	@echo generating an example .tex and .pdf to: examples/
	@echo
	@echo stack:
	@echo ======
	@echo
	stack exec latexume "examples/example.md"
	@echo
	@echo pdflatex:
	@echo =========
	@echo
	pdflatex generated/$(name).tex
	@echo
	@echo mv generated files to examples/:
	@echo ================================
	@echo
	mv generated/$(name).tex examples/$(name).tex
	mv $(name).pdf examples/$(name).pdf
	rm $(name).aux
	rm $(name).log

clean:
	rm *.aux *.log examples/*.aux examples/*.log *.pdf generated/*
