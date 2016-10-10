is.integer0 <- function(x){
  is.integer(x) && length(x) == 0L
}


COMPOSITE <- read.table("data.index/composite.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE)
LQ45 <- read.table("data.index/lq45.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE)
JII <- read.table("data.index/jii.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE)
ISSI <- read.table("data.index/issi.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE)
