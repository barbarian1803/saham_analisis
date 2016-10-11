library("stringr")
fileList <- list.files("data")
metadata <- read.table("metadata/kode_sektor.csv",header=TRUE,sep=";",stringsAsFactors = FALSE)

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
row.names(mergedPrice) <- str_replace(row.names(mergedPrice),"price-","")

mergedPrice <- mergedPrice[nrow(mergedPrice):1,]


getLastdata <- function(v){
  v[length(v)]
}

trimLast <- function(d){
  x <- unlist(strsplit(d,"[.]"))
  x[1]
}

calculateDiff <- function(saham){
  Saham <- c(0)
  for(i in 1:nrow(mergedPrice)-1){
    Saham <- c(Saham,((mergedPrice[i+1,saham]-mergedPrice[i,saham])/mergedPrice[i,saham])*100)
  }
  return(Saham)
}

makeHist <- function(saham){
  Saham <- calculateDiff(saham)
  print(summary(Saham))
  print(var(Saham))
  boxplot(Saham)
  hist(Saham,breaks = 100)
  return(Saham)
}