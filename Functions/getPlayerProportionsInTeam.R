getPlayerProportionsInTeam <- function(allPlayerTables, playerNameURL, gameWeeks = NULL){
  
  if(is.null(gameWeeks)) stop("No game weeks specified")

  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  teamNames = c("MUN","WBA","TOT","ARS","BRN","LEI","LIV","WAT","HUD","MCI","SOU","CHE","EVE","SWA","CRY","WHU","BOU","STK","NEW","BHA")
  names(teamNames) = teamNames
  
  playersInTeam = lapply(teamNames, function(tn) {
    playerNames = row.names(playerNameURL)[playerNameURL$Team == tn]
    playerNames = playerNames[ !is.na(playerNames)]
  })
  
  teamSepList = lapply(teamNames, function(pIT) {
    teamOut = allPlayerTables[playersInTeam[[pIT]]]
    teamOut[ !is.na(names(teamOut))]
  })
  
  teamByWeekProportions = lapply(teamNames, function(tn) {
    teamIn = teamSepList[[tn]]
    teamByWeekList = lapply(gameWeeks, function(gw) do.call(rbind, lapply(teamIn, function(y) y[gw, vars])))
    teamByWeekProportions =lapply(teamByWeekList, function(tbwl) round(t(t(tbwl)/colSums(tbwl)), 2))
    namesUni = unique(do.call(c, lapply(teamByWeekProportions, function(tbwp) row.names(tbwp))))
    teamByWeekProportions = do.call(rbind, lapply(namesUni, function(x) 
      colMeans(do.call(rbind, lapply(teamByWeekProportions, function(y) y[x,])), na.rm = T)))
    row.names(teamByWeekProportions) <- namesUni
    teamByWeekProportions[is.nan(teamByWeekProportions)] <- 0
    return(teamByWeekProportions)
  })
  
  return(teamByWeekProportions)

}