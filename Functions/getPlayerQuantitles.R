getPlayerQuantitles <- function(playerGLMs, allPlayerList, quantitles = NULL){
  
  allPlayerListMat = do.call(rbind, allPlayerList)
  
  if(is.null(quantitles)){
    QQs = structure(c(10,50,90), names = c("Q10", "Q50", "Q90"))
  }else{
      QQs = structure(quantitles, names = paste("Q", quantitles, sep = ""))
    }
  
  qqScores = lapply(QQs, function(x) quantitleScores(playerGLMs, x))
  
  lapply(qqScores, function(x){
    playerPos = sapply(row.names(x), function(y) allPlayerListMat$POS[grep(y, row.names(allPlayerListMat))[1]])
    qqScoresFull = data.frame(POS = playerPos, x)
  })
}


