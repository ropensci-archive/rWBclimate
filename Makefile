all: move pandoc rmd2md reducepdf

move:
	cp inst/stuff/rWB* vignettes

pandoc:
	cd vignettes;\
pandoc -H margins.sty rWBclimate_vignette.md -o rWBclimate_vignette.pdf --highlight-style=tango;\

rmd2md:
	cd vignettes;\
  cp rWBclimate_vignette.md rWBclimate_vignette.Rmd;\
  mv rWBclimate_vignette.md rWBclimate_vignette.Rmd;\
  mv rWBclimate_vignette.pdf vignette.pdf

reducepdf:
	Rscript -e 'tools::compactPDF("vignettes/vignette.pdf", gs_quality = "ebook")';\