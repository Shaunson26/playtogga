getTeamList <- function(allPlayerTableList){
  temp.mat = do.call(rbind, allPlayerTableList)
  uniqueTeams = unique(temp.mat[, "Team"])
  allTeam.list = lapply(uniqueTeams, function(tm) temp.mat[ temp.mat[,"Team"] == tm,])
  names(allTeam.list) <- uniqueTeams
  allTeam.list
}

sepGameWeekinTeam <- function(allTeamList){
  gwByTeam.list = lapply(allTeamList, function(tm) {
    gameWeeks = unique(tm[, "GW"])
    gameWeek.list = lapply(gameWeeks, function(gw) tm[ tm[,"GW"] == gw,])
    names(gameWeek.list) = gameWeeks
    return(gameWeek.list)
  })
}

returnTableProps = function(table){
  info = c("Name", "Team", "POS")
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  tblIn = table[, vars]
  tblIn = t(t(tblIn) / colSums(tblIn))
  tblIn[ is.nan(tblIn)] <- 0
  tblOut = data.frame(table[, info], tblIn)
  return(tblOut)
}


playerProps = function(list){
  info = c("Name", "Team", "POS")
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  dat.mat = do.call(rbind, list)
  tblOut = t(sapply(unique(dat.mat$Name), function(nm) colMeans( dat.mat[ dat.mat$Name == nm, vars])))
  statOut = do.call(rbind, lapply(unique(dat.mat$Name), function(nm) dat.mat[ dat.mat$Name == nm, info][1,]))
  tblOut = data.frame(statOut, tblOut)
  row.names(tblOut) <- tblOut$Name
  tblOut
}