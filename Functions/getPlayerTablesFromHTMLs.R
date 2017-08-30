getPlayerTablesFromHTMLs <- function(filesIn){
  
  require(XML)
  
  allDatList = list()
  
  for(i in 1:length(filesIn)){
    htmlIn = readLines(filesIn[i], encoding = 'UTF-8', warn = F)
    tableIn <- readHTMLTable(htmlIn)[[1]]
    names(tableIn) <- as.character(t(tableIn[1,]))
    tableIn = tableIn[-1,]
    rownames(tableIn) = 1:nrow(tableIn)
    for(j in c(1,3:ncol(tableIn))){ tableIn[,j] = as.numeric(as.character(tableIn[,j]))}
    
    # Add position
    #nameLoc = grep("class=\"name\"", htmlIn)[1]
    #posType = sub(".+ | ", "", sub(" \\| <.+", "", htmlIn[nameLoc+1]))
    #shortPosType = c("FOR", "MID", "DEF", "GOA")[c("Forward", "Midfielder", "Defender", "Goalkeeper") %in% posType]
    
    # Add team?
    
    # Join data.frame
    #tableIn = data.frame(POS = shortPosType, tableIn)
    tableIn = data.frame(tableIn)
    allDatList[[i]] = tableIn
    names(allDatList)[i] = sub(".html", "", filesIn[i])
  }
  
  return(allDatList)
}