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

row.names(JII) <- as.Date(row.names(JII),format="%d-%b-%y")
JII <- subset(JII,select = c(4))
dadinar <- read.table("RD/DADINAR.csv",header=FALSE,sep="\t",row.names = 1,stringsAsFactors = FALSE)
row.names(dadinar) <- as.Date(row.names(dadinar),format="%d/%m/%Y")
colnames(dadinar)<-"dadinar"
merged <- merge(dadinar,JII,by="row.names")
cor(merged$Close,merged$dadinar)
