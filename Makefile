all: pandoc move 


pandoc:
	cd inst/stuff/;\
pandoc -H margins.sty rWBclimate_vignette.md -o rWBclimate_vignette.pdf --highlight-style=tango;\

move:
	mv inst/stuff/rWBclimate_vignette.pdf inst/stuff/vignette.pdf
	cp inst/stuff/*.pdf vignettes;\
  