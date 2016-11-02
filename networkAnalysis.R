Sample40D <- mergedAll[,642:681]
adjMatrix <- matrix(0,nrow=nrow(Sample40D),ncol=nrow(Sample40D))
colnames(adjMatrix)<-rownames(Sample40D)
rownames(adjMatrix)<-rownames(Sample40D)
