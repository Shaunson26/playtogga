getIndividualPlayerTables <- function(filesIn){
  
  require(XML)
  
  allDatList = list()
  
  for(i in 1:length(filesIn)){
    htmlIn = readLines(filesIn[i], encoding = 'UTF-8', warn = F)
    tableIn <- readHTMLTable(htmlIn)[[1]]
    names(tableIn) <- as.character(t(tableIn[1,]))
    tableIn = tableIn[-1,]
    rownames(tableIn) = 1:nrow(tableIn)
    for(j in c(1,3:ncol(tableIn))){ tableIn[,j] = as.numeric(as.character(tableIn[,j]))}
    #minsIn = htmlIn[grep("MIN", htmlIn)]
    #minsIn = sub(".+<br..> ", "", minsIn)
    #minsIn = sub(" .+", "", minsIn)
    #allDatList[[i]] = list(playerDat = tableIn, minsPlayed = minsIn)
    
    allDatList[[i]] = tableIn
    names(allDatList)[i] = sub(".html", "", filesIn[i])
  }
  
  return(allDatList)
}