DADINAR <- mergedPrice[420:431,c("TLKM","ASII","UNVR","ICBP","KLBF")]
DADINAR$RD <- c(3159.05,
                3167.49,
                3136.23,
                3184.47,
                3184.96,
                3204.46,
                3133.10,
                3203.64,
                3203.21,
                3162.21,
                3147.47,
                3124.91)

glm(formula=RD~TLKM+ASII+UNVR+ICBP+KLBF,data=DADINAR)

x <- glm(formula=RD~TLKM+ASII+UNVR+ICBP+KLBF,data=DADINAR)

summary(x)
