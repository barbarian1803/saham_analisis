calculateWeight <- function(u){
  w <- c()
  
  for(el in u){
    if(1-abs(el)>0){
      w <- c(w,((1-el**2)**2))
    }else{
      w <- c(w,0)
    }
  }
  
  return(w)
}

calcU <- function(v,med.v){
  mad.V <- median(abs(v-med.v))
  if(mad.V==0){
    mad.V = 0.001
  }
  u <- (v-med.v)/(9*mad.V)
  return(u)
}

biweightCorr <- function(v1,v2){
  med.v1 <- median(v1)
  med.v2 <- median(v2)
  
  u1 <- calcU(v1,med.v1)
  u2 <- calcU(v2,med.v2)
  
  w1 <- calculateWeight(u1)
  w2 <- calculateWeight(u2)
  
  x <- ((v1-med.v1)*w1)/sqrt(sum(((v1-med.v1)*w1)**2))
  y <- ((v2-med.v2)*w2)/sqrt(sum(((v2-med.v2)*w2)**2))
  
  corr <- sum(x*y)
  return(corr)
}