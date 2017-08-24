getPlayerQuantiles <- function(playerGLMs, allPlayerList, quantiles = NULL){
  
  allPlayerListMat = do.call(rbind, allPlayerList)
  
  if(is.null(quantiles)){
    QQs = structure(c(10,50,90), names = c("Q10", "Q50", "Q90"))
  }else{
      QQs = structure(quantiles, names = paste("Q", quantiles, sep = ""))
    }
  
  qqScores = lapply(QQs, function(x) quantileStatistics(playerGLMs, x))
  
  lapply(qqScores, function(x){
    playerPos = sapply(row.names(x), function(y) allPlayerListMat$POS[grep(y, row.names(allPlayerListMat))[1]])
    qqScoresFull = data.frame(POS = playerPos, x)
  })
}


