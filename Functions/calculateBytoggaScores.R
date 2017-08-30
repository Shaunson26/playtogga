calculateBytoggaScores <- function(qqScoresList, eventScores){
  
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  
  sapply(qqScoresList, function(x) rowSums(x[, vars] * t(eventScores[vars, x$POS]), na.rm = T))
}