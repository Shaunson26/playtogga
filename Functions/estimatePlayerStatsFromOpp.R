estimatePlayerStatsFromOpp <- function(allPlayerTableList, playerPropList, allTeamAgainstMeansDF, gameWeek = NULL){
  
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  
  oppTeam = sapply(allPlayerTableList, function(apt) apt[ apt$GW == gameWeek, "OPP"])
  oppTeam = structure(sub(",", "", sub("@", "", sub(",.+", "", oppTeam))), names = names(allPlayerTableList))
  
  playerProp.mat = do.call(rbind, playerPropList)
  anyNA(oppTeam[playerProp.mat$Name])
  
  estPlayerOppStats = lapply(playerProp.mat$Name, function(nm){
    # Team data
    teamIn = allTeamAgainstMeansDF[oppTeam[nm],]
    # player data
    playerIn = playerProp.mat[ playerProp.mat$Name == nm, vars]
    # Multiply
    teamIn * playerIn})
  
  names(estPlayerOppStats) <- playerProp.mat$Name
  
  do.call(rbind, addPlayerInfoToPlayerTable(estPlayerOppStats, playerURLTeamPosition))

}