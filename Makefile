all: pandoc move reducepdf


pandoc:
	cd inst/stuff/;\
pandoc -H margins.sty rWBclimate_vignette.md -o rWBclimate_vignette.pdf --highlight-style=tango;\

move:
	mv rWBclimate_vignette.pdf vignette.pdf
	cp inst/stuff/*.pdf vignettes;\
  

reducepdf:
	Rscript -e 'tools::compactPDF("vignettes/vignette.pdf", gs_quality = "ebook")';\