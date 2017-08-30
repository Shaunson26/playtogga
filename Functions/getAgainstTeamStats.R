getAgainstTeamStats <- function(allPlayerTableList){
  
  temp.mat = do.call(rbind, allPlayerTableList)
  temp.mat$OPP = sub("@", "", sub(",", "", sub(",.+", "", temp.mat$OPP)))
  uniqueTeams = unique(temp.mat[, "OPP"])
  
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  
  allTeam.list = lapply(uniqueTeams, function(tm) {
    matOut = temp.mat[ temp.mat[,"OPP"] == tm,]
    matOut = matOut[ !is.na(matOut$PTS),]
    gameWeeks = unique(matOut[, "GW"])
    t(sapply(gameWeeks, function(gw) colSums(matOut[ matOut[,"GW"] == gw, vars])))
    #names(gameWeek.list) = gameWeeks
    #return(gameWeek.list)
  })
  
  names(allTeam.list) <- uniqueTeams
  
  round(t(sapply(allTeam.list, function(x) colMeans(x))),1)
}
  
