getPlayerByOppTeamStats <- function(playerTable, playerTeamProportion, teamAgainstStats){
  
  playerByOppTeam = data.frame(do.call(rbind, 
                                       lapply(1:nrow(playerTable), function(x) {
                                         playerIn = playerTeamProportion[row.names(playerTable)[x],]
                                         oppIn = as.numeric(teamAgainstStats[playerTable$OPP[x],])
                                         playerIn * oppIn  
                                       })
  ))
  
  playerByOppTeam = data.frame(POS = playerTable$POS, playerByOppTeam)
  row.names(playerByOppTeam) <- row.names(playerTable)
  
  return(playerByOppTeam)
}