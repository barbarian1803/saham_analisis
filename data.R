metadata <- read.table("metadata/kode_sektor.csv",header = TRUE,sep = ";",stringsAsFactors = FALSE)
loadData <- function(dir){
  files <- list.files(dir)
  readAll <- list()
  i <- 1
  for(f in files){
    temp <- read.table(paste(dir,f,sep="/"),header=TRUE,sep=",",quote="",stringsAsFactors = FALSE)
    temp <- temp[,c(1,2,3,7)]
    colnames(temp) <- c("date","code","name",temp[1,1])
    temp <- temp[,-c(1,3)]
    readAll[[i]] <- temp[temp$code%in%metadata$Kode,]
    i<-i+1
  }
  readAll
}

data <- loadData("data")

setdiff(data[[681]]$code,metadata$Kode)
mergedAll = Reduce(function(...) merge(..., by="code",all=TRUE), data)
mergedAll[is.na(mergedAll)] <- 0
row.names(mergedAll)<-mergedAll$code
mergedAll <- mergedAll[,-c(1)]

calculateCDiff <- function(strt,end){
  return(100*((end-strt)/strt))
}

diffData <- mergedAll[,-c(1)]

for(i in 1:nrow(diffData)){
  for(j in 1:(ncol(diffData))){
    diffData[i,j] <- calculateCDiff(mergedAll[i,j],mergedAll[i,j+1])
  }
}


showPlot<-function(name,start,end){
  plot(t(mergedAll[name,start:end]),type="l")
}