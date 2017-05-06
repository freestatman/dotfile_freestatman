#!/lrlhps/apps/R/R-3.2.0/bin/Rscript
#!/usr/local/bin/Rscript
args=commandArgs(TRUE)
path=args[1]

if (FALSE) {    # debug
	#library(utils)
	#source('~/R/R-3.0.2/src//library/utils/R/rtags.R')
	debug('rtags')
	path <- "/home/swa/Asian"
	rtags.path <- file.path(path, 'TAGS')
}    # End debug

rtags(path=path,
	  pattern = "[.]*\\.[RrSs]$",
	  keep.re = ".",
	  verbose = TRUE,
	  ofile = file.path(path, 'TAGS'),
	  append = FALSE,
	  recursive = TRUE)

