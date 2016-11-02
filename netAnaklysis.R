Sample30D <- mergedAll[,652:681]
tesAdjMatrix <- matrix(0,nrow=nrow(Sample30D),ncol=nrow(Sample30D))
colnames(tesAdjMatrix) <- row.names(Sample30D)
row.names(tesAdjMatrix) <- row.names(Sample30D)

for(col in c(1:(ncol(tesAdjMatrix)-1))){
  for(row in c((col+1):nrow(tesAdjMatrix))){
    cname <- colnames(tesAdjMatrix)[col]
    rname <- row.names(tesAdjMatrix)[row]
     
    res <- biweightCorr(t(Sample30D[cname,]),t(Sample30D[rname,]))
    tesAdjMatrix[cname,rname] <- res
    tesAdjMatrix[rname,cname] <- res
  }
}

for(col in c(1:(ncol(tesAdjMatrix)))){
  for(row in c(1:nrow(tesAdjMatrix))){
    if(is.na(tesAdjMatrix[col,row])){
      tesAdjMatrix[col,row]<-0
    }
  }
  tesAdjMatrix[col,col]<-0
}

tesAdjMatrixPow12 <- (abs(0.5+0.5*tesAdjMatrix))**12

vector <- c(tesAdjMatrixPow8)
vector <- c(tesAdjMatrixPow20)
vector <- c(tesAdjMatrixPow4)
vector <- c(tesAdjMatrixPow12)
hist(vector)
m <- hist(vector)
plot(log10(m[["breaks"]][1:18]),log10(m[["counts"]]))
