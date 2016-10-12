DANMPUT <- read.table("RD/DANMPUT.csv",header=FALSE,quote="",sep="\t")
colnames(DANMPUT) <- c("date","price")
summary(DANMPUT$price)
DANMPUT[duplicated(DANMPUT$date),]
rm(DANMPUT_rev)
