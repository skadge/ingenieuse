OUTPUT ?= pdf
SRCS := $(sort $(wildcard src/*.md))

TARGET := book.pdf

SVG := $(wildcard figs/*.svg)
SVG += $(wildcard template/*.svg)

all: project

%.pdf: %.svg
	inkscape --export-pdf $(@) $(<)

%.png: %.svg
	inkscape -d 200 --export-png $(@) $(<)

project: $(SVG:.svg=.pdf)
	pandoc $(SRCS) -McodeBlockCaptions=true -MfigureTitle=Figure -o $(TARGET)  --template=style/template.tex --pdf-engine=lualatex --dpi=300 --standalone --resource-path=.:src/figs
