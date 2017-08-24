calculateBytoggaScores <- function(qqScoresList, eventScores){
  
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  
  lapply(qqScoresList, function(x){
    
    datOut = t(sapply(1:nrow(x), function(y){
      posIn = x$POS[y]
      datIn = x[ y, vars]
      datIn[, vars] * eventScores[ vars, posIn ]
      }))
    datOut = as.matrix.data.frame(datOut)
    row.names(datOut) = row.names(x)
    rowSums(datOut,na.rm = T)
    })
}