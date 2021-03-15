.PHONY: all example clean

name = latexume

all:
	pdflatex generated/$(name).tex

example:
	stack exec latexume "examples/example.md" "Just Me" "me@mail.com" "github.com/me"
	pdflatex generated/$(name).tex
	mv generated/$(name).tex examples/$(name).tex
	mv $(name).pdf examples/$(name).pdf

clean:
	rm *.aux *.log examples/*.aux examples/*.log *.pdf generated/*
