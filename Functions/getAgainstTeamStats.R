getGameWeekAgainstStats <- function(getAgainstTeamStats, gameWeeks = NULL){
  
  if(is.null(gameWeeks)) stop("No game weeks specified")
  
  lapply(againstTeamStats, function(ats){
    gWAP =  t(sapply(gameWeeks, function(x) colSums(ats[ats$GW == x, -(1:4)])))
    gcReal = t(sapply(gameWeeks, function(x) max(ats[ats$GW == x,  "GC"])))
    gWAP[, "GC"] <- gcReal
    return(gWAP)
  })}

getAgainstTeamStats <- function(playerTables){
  
  teamNames = c("MUN","WBA","TOT","ARS","BRN","LEI","LIV","WAT","HUD","MCI","SOU","CHE","EVE","SWA","CRY","WHU","BOU","STK","NEW","BHA")
  
  againstTeamStats = lapply(teamNames, function(tn) {
    teamMat =  do.call(rbind, lapply(playerTables, function(x) x[grep(tn, x$OPP),]))
    teamMat = teamMat[!is.na(teamMat$PTS),]
    })
  
  names(againstTeamStats) <- teamNames
  
  return(againstTeamStats)
}