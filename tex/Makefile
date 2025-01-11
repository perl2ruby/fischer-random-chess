# Makefile for compiling LaTeX documents using pdflatex

# Name of the LaTeX file (without extension)
TARGET = fischer-random-chess

# Default rule
all: $(TARGET).pdf

# Rule to generate PDF from LaTeX
$(TARGET).pdf: $(TARGET).tex
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex

# Clean up auxiliary files
clean:
	rm -f $(TARGET).aux $(TARGET).log $(TARGET).out $(TARGET).toc $(TARGET).pdf

# Clean up auxiliary files and the PDF
cleanall: clean
	rm -f $(TARGET).pdf

.PHONY: all clean cleanall
