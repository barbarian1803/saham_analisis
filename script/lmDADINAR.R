changeRowNames <- function(x){
  l <- unlist(str_split(x,"/"))
  p <- paste(l[3],l[2],l[1],sep="-")
  return(p)
}

DADINAR <- read.table("RD/DADINAR.csv",header=FALSE,quote = "",sep="\t",stringsAsFactors = FALSE,row.names = 1)
colnames(DADINAR)<- "DADINAR"
row.names(DADINAR)<-sapply(row.names(DADINAR), changeRowNames)

merged <- merge(DADINAR,mergedPrice[,c("TLKM","ASII","UNVR","ICBP","KLBF")],by="row.names")
row.names(merged)<-merged$Row.names
merged <- merged[,-c(1)]
merged <- merged[nrow(merged):1,]

merged <- merged[1:268,]
plot(DADINAR~TLKM,data=merged)
plot(DADINAR~ASII,data=merged)
plot(DADINAR~UNVR,data=merged)
plot(DADINAR~ICBP,data=merged)
plot(DADINAR~KLBF,data=merged)
cor(merged$DADINAR,merged$TLKM)
cor(merged$DADINAR,merged$ASII)
cor(merged$DADINAR,merged$UNVR)
cor(merged$DADINAR,merged$ICBP)
cor(merged$DADINAR,merged$KLBF)





x <- lm(formula=DADINAR~TLKM+ICBP+KLBF,data=merged)
summary(x)
round(coefficients(x),3)
x <- lm(formula=DADINAR~ASII+ICBP+KLBF,data=merged)
summary(x)
round(coefficients(x),3)
x <- lm(formula=DADINAR~UNVR+ICBP+KLBF,data=merged)
summary(x)
round(coefficients(x),3)

coeff[1]+coeff[2]*4160+coeff[3]*8275+coeff[4]*44600+coeff[5]*9625+coeff[6]*1715






JIImeta <- read.table("metadata/JII.csv",header=TRUE,sep = "\t",row.names = 2,stringsAsFactors = FALSE)
JIIstock <- mergedPrice[,intersect(colnames(mergedPrice),rownames(JIImeta))]
JIIPCA <- prcomp(JIIstock,scale. = TRUE,center = TRUE)
plot(JIIPCA,type="l")
summary(JIIPCA)
Loadings <- as.data.frame(JIIPCA$rotation[,1:2])
JIIPCA$rotation

DADINARmerged <- merge(DADINAR,JIIstock,by = "row.names")
row.names(DADINARmerged) <- DADINARmerged[,1]
DADINARmerged<-DADINARmerged[,-c(1)]
m <- scale(t(DADINARmerged[400:485,]))
l <- dist(m)
m <- hclust(l)
plot(m)
