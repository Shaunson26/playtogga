setwd("C:/Users/Shaunus/Desktop/Togga")

library(XML) 

# Scraped full player table from playtogga
theurl <- readLines("allPlayerTable.html", encoding = 'UTF-8', warn = F)

# grep HTML lines with 'player' class
playerLines = grep("players", theurl)

# get playerName
subStart = theurl[playerLines]
playerName = sub(".+> ","", subStart)
playerName = sub(" <.+", "", playerName)

# get playerURL
subStart = theurl[playerLines]
subStart = sub(".+href=..", "", subStart)
playerURL = sub(".> .+", "", subStart)

# get playerPosition
subStart = theurl[grep("player-pos", theurl)]
playerPos = sub(".+> ","", subStart)
playerPos = sub(" <.+", "", playerPos)

# get playerTeam
teamCrests = grep("team-crest", theurl)
teamName = toupper(unlist(lapply(teamCrests, function(x) substr(theurl[x], 68, 70))))

# make data.frame
playerURLTeamPosition = data.frame(cbind(Name = playerName, URL = playerURL, Team = teamName, POS = playerPos))

# double names
nameTable = names(which(table(playerURLTeamPosition$Name) > 1))
playerURLTeamPosition$Name = as.character(playerURLTeamPosition$Name)

for(i in nameTable){
  rowsIn = which(playerURLTeamPosition$Name == i)
  playerURLTeamPosition$Name[rowsIn] <- paste(playerURLTeamPosition[rowsIn, "Name"], playerURLTeamPosition[rowsIn, "Team"], sep = "_")
}

gamesPlayed = as.numeric(as.character(readHTMLTable(theurl)[[1]][-(1:2),8]))
playerURLTeamPosition$gamesPlayed = gamesPlayed

save(playerURLTeamPosition, file = "playerNamesURLs_Aug2017.RData")
