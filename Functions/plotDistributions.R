plotAllPlayerDistributions <- function(allPlayerGLMs){
  
  playerNames = names(allPlayerGLMs)
  
  for(i in 1:length(playerNames)){
    plotDistributions(pW2Glms[[i]], main = playerNames[i])
  }
}


plotDistributions <- function(myFit, main = NULL...){
  require(lattice)
  
  datIn = t(do.call(rbind, lapply(myFit, function(x) x$outPcnt)))
  datInStack = stack(as.data.frame(datIn))
  datInStack$hits = as.numeric(row.names(datIn))
  
  print(
    barchart(values ~ hits | ind, data = datInStack,
           main = main, xlab = "Hits", ylab = "% likelihood",
           layout = c(6,3), between = list(x = 0.5, y = 0.5),
           scales = list(alternating = F, x = list(rot = 90)),
           horizontal = F)
  )
}