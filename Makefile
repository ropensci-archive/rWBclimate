all: pandoc move 


pandoc:
	cd inst/stuff/;\
pandoc -H margins.sty rWBclimate_vignette.md -o rWBclimate.pdf --highlight-style=tango;\

move:
	cp inst/stuff/*.pdf ../doc;\
  