getPlayerQuantiles <- function(manyGLMs, allPlayerTableList = NULL, quantiles = NULL){
  
  ## Add names to quantitles
  if(is.null(quantiles)){
    QQs = structure(c(10,50,90), names = c("Q10", "Q50", "Q90"))
  }else{
      QQs = structure(quantiles, names = paste("Q", quantiles, sep = ""))
    }
  
  qqScores = lapply(QQs, function(qq) 
    t(sapply(manyGLMs, function(mglm) quantileStatistics(mglm, qq)))
  )
  
  ## Fix CS and others for team
  if(is.null(allPlayerTableList)){
  for(i in 1:length(qqScores)){
    qqScores[[i]][,"CS"][qqScores[[i]][,"GC"] == 0] <- 11
    qqScores[[i]][,"CS"][qqScores[[i]][,"GC"] > 0] <- 0
    
    for(col in 1:ncol(qqScores[[i]])){
      qqScores[[i]][,col][is.na(qqScores[[i]][,col])] <- max(qqScores[[i]][,col], na.rm = T)
    }
  }}
    
  ## Add player names if they are there
  if(!is.null(allPlayerTableList)){
    
    for(i in 1:length(qqScores)){
      qqScores[[i]][,"CS"][qqScores[[i]][,"CS"] > 1] <- 1
      qqScores[[i]][,"YC"][qqScores[[i]][,"YC"] > 1] <- 1
    }
    
    info = c("Name", "Team", "POS")
    
    return(
      lapply(qqScores, function(qqs){
    playerInfo = do.call(rbind, lapply(row.names(qqs), function(x) allPlayerTableList[[x]][1, info]))
    data.frame(playerInfo, qqs)
      }))
    }else{
      return(qqScores)
    }
}


quantileStatistics <- function(myFit, quantileThreshold = 50){
  sapply(myFit, function(tm) {
    cumsumPcnts = cumsum(tm$outPcnt)
    as.numeric(names(tm$outPcnt[cumsumPcnts > quantileThreshold][1]))
  })
}