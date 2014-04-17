all: pandoc move rmd2md

vignettes: 
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rWBclimate.Rmd");'

move:
		cp inst/vign/rWBclimate.md vignettes;\
		cp inst/vign/rWBclimate.pdf vignettes;\
		cp inst/vign/rWBclimate.html vignettes;\

pandoc:
		cd inst/vign;\
		pandoc -H margins.sty rWBclimate.md -o rWBclimate.pdf --highlight-style=tango;\
		pandoc -H margins.sty rWBclimate.md -o rWBclimate.html --highlight-style=tango;\


rmd2md:
		cd vignettes;\
		cp rWBclimate.md rWBclimate.Rmd;\