# Fischer Random Chess
## Introduction
Fischer Random Chess is a variant of Chess. To know more about Fisher Random Chess, please to the (Chess960)[https://en.wikipedia.org/wiki/Chess960] wiki page.
This repo is used to create a LaTeX document that shows how there are 960 unique starting combinations for Fischer Random Chess. We also enumrate these 960 unique combinations.

## Contents of Repo
The following are important files:
+ [simple-gen-fisher-random-placements.rb](./ruby/simple-gen-fisher-random-placements.rb)
  : This is a script that generates all the unique starting placements in a text in a tabular form with N number of placements per row. There is also pagination after every M rows.
+ [gen-fisher-random-placements.rb](./ruby/gen-fisher-random-placements.rb)
  : This is a script that generates all the unique starting placements in LaTeX tabular form that is suitable for insertion into [fischer-random-chess.tex.template](./tex/fischer-random-chess.tex.template) between `BEGIN: pasting` and [END: pasting] and generates the file [fischer-random-chess.tex](./tex/fischer-random-chess.tex)
+ [fischer-random-chess.tex](./tex/fischer-random-chess.tex)
  : This is the file that is to be composed using PDFLaTeX after it has been created using [gen-fisher-random-placements.rb](./ruby/gen-fisher-random-placements.rb) and [fischer-random-chess.tex.template](./tex/fischer-random-chess.tex.template)
+ [Makefile](./tex/Makefile)
  : This is the makefile that is used to compose [fischer-random-chess.tex](./tex/fischer-random-chess.tex) to create [fischer-random-chess.pdf](./tex/fischer-random-chess.pdf)
+ [fischer-random-chess.pdf](./tex/fischer-random-chess.pdf)
  : This is the file that is generated by composing [fischer-random-chess.tex](./tex/fischer-random-chess.tex) using PDFLaTeX


## PDF Document Generation
To generate the PDF ([fischer-random-chess.tex](./tex/fischer-random-chess.tex)) run the following command(s):
+ 
```
make cleanall # To clean up auxiliary files and the generated PDF
make clean    # To clean up auxiliary files
make          # To compile the LaTeX file and generate the PDF
```

Note that only make should suffice most of the time.
