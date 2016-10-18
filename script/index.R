is.integer0 <- function(x){
  is.integer(x) && length(x) == 0L
}


COMPOSITE <- read.table("data.index/composite.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE)
LQ45 <- read.table("data.index/lq45.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE)

ISSI <- read.table("data.index/issi.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE)
JII <- read.table("data.index/jii.csv",header=TRUE,sep=",",quote = "",stringsAsFactors = FALSE,row.names = 1)


changeDateFormat <- function(date){
  dateSplit <- unlist(strsplit(date,"-"))
  
}

n <- as.Date(row.names(JII)[1],format="%d-%h-%y")
dates <- c("05/27/84", "07/07/05")
betterDates <- as.Date(dates,format = "%m/%d/%y")
