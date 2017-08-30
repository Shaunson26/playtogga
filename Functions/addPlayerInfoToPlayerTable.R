addPlayerInfoToPlayerTable <- function(allPlayerTableList, playerURLTeamPosition){
  
  for(i in 1:length(allPlayerTableList)){
    rowIn = which(names(allPlayerTableList)[i] == playerURLTeamPosition[, "Name"])
    playerDatIn = data.frame(playerURLTeamPosition[rowIn , c("Name", "Team", "POS")], row.names = NULL)
    allPlayerTableList[[i]] = data.frame(playerDatIn, allPlayerTableList[[i]])
  }
  return(allPlayerTableList)
}