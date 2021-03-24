.PHONY: all example clean

name = latexume

all:
	pdflatex generated/$(name).tex

example:
	@echo generating an example .tex and .pdf to: examples/
	@echo .................................................
	@echo
	@echo stack:
	@echo ======
	@echo
	stack exec latexume "examples/example.md" "Just Me" "me@mail.com" "github.com/me"
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

clean:
	rm *.aux *.log examples/*.aux examples/*.log *.pdf generated/*
