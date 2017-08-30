plotAllPlayerDistributions <- function(allPlayerGLMs){
  
  playerNames = names(allPlayerGLMs)
  
  for(i in 1:length(playerNames)){
    plotOnePlayerDistributions(allPlayerGLMs[[i]], main = playerNames[i])
  }
}


plotOnePlayerDistributions <- function(myFit, main = NULL, ...){
  require(lattice)
  
  #datIn = t(do.call(rbind, lapply(myFit, function(x) x$outPcnt)))
  #colnames(datIn) = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  #datInStack = stack(as.data.frame(datIn))
  #datInStack$hits = as.numeric(row.names(datIn))
  
  
  values = do.call(c, lapply(myFit, function(x) x$outPcnt))
  
  datIn = data.frame(values,
                     hits = as.numeric(sub(".+\\.", "", names(values))),
                     ind = sub("\\..+", "", names(values)))
  
  datIn = datIn[ datIn$values > 0.5,]
  
  print(
    barchart(values ~ hits | ind, data = datIn,
           main = main, xlab = "Hits", ylab = "% likelihood", col = "grey50",
           layout = c(6,3), between = list(x = 0.5, y = 0.5),
           scales = list(alternating = F, 
                         x = list(rot = 0, labels = 0:40, at = 1:41, relation = "free")),
           horizontal = F)
  )
}

