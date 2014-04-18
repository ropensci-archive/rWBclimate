all: move pandoc rmd2md reducepdf

vignettes: 
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rWBclimate.Rmd");'

move:
		cp inst/vign/rWBclimate.md vignettes;\
		cp -r inst/vign/figure vignettes;\


pandoc:
		cd vignettes;\
		pandoc -H margins.sty rWBclimate.md -o rWBclimate.pdf --highlight-style=tango;\
		pandoc -H margins.sty rWBclimate.md -o rWBclimate.html --highlight-style=tango;\


rmd2md:
		cd vignettes;\
		cp rWBclimate.md rWBclimate.Rmd;\

reducepdf:
		Rscript -e 'tools::compactPDF("vignettes/rWBclimate.pdf", gs_quality = "ebook")';\