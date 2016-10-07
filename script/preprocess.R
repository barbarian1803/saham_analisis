fileList <- list.files("data")
metadata <- read.table("metadata/kode_sektor.csv",header=TRUE,sep=";",stringsAsFactors = FALSE)


getLastdata <- function(v){
  v[length(v)]
}

trimLast <- function(d){
  x <- unlist(strsplit(d,"[.]"))
  x[1]
}

date <- sapply(fileList,trimLast,USE.NAMES = FALSE)


listHistory <- list()
for( d in date){
  fname <- paste("data/",d,".TXT",sep="")
  read <- read.table(fname,header=TRUE,sep=",",stringsAsFactors = FALSE)
  listHistory[[d]] <- read[read$X.ticker.!="^",]
  row.names(listHistory[[d]]) <- listHistory[[d]]$X.ticker.
  listHistory[[d]] <- listHistory[[d]][,7:8]
  colnames(listHistory[[d]]) <- c(paste("price-",d,sep=""),paste("vol-",d,sep=""))
}

for( i in 1:length(listHistory)){
  listHistory[[i]] <- listHistory[[i]][metadata$Kode,]
  listHistory[[i]]$kode <- row.names(listHistory[[i]])
}

mergedAll = Reduce(function(...) merge(..., by="kode"), listHistory)
row.names(mergedAll) <- mergedAll$kode

mergedAll <- subset(mergedAll,select = -kode)
mergedPrice <- mergedAll[, grep("price",colnames(mergedAll))]
mergedVol <- mergedAll[, grep("vol",colnames(mergedAll))]


mergedPrice <- as.data.frame(t(mergedPrice))
mergedPrice$date <- row.names(mergedPrice)

ggplot(data=mergedPrice, aes(x=date, y=TLKM, group=1)) + geom_point()+geom_line()+xlab("")+ylab("")
ggplot(data=mergedPrice, aes(x=date, y=ASII, group=1)) + geom_point()+geom_line()+xlab("")+ylab("")
cor(mergedPrice$ASII,mergedPrice$TLKM)
