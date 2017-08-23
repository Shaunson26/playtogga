# playtogga
Functions and data for scraping/downloading playtogga FPL data.  

# The process
With my limited expertise, I have put together some R functions for scraping the player tables from playtogga. The main scrape function uses RSelenium to run your brower, login, and then use a user-specified file (an updated file of each and every player is provided) that nagivates to the player tables wanted and the HTMLs are saved. Another function extracts uses the XML package to extract tables from the HTMLs, cleans them and puts them into a list in R.

## Downlading HTMLs

Source the download function and the player url file (character matrix with name, url, team and position columns).
`source("Functions/downloadPlayerHTMLs.R")`  
`load("Data/playerNamesURLs_Aug2017.RData")`  
  
Run the function, which will save the HTMLs in the current directory.  
`downloadPlayerHTMLs(login = "user", password = "password", playerNameURL = playerNameURL)`

## Cleaning player tables

Source the player table function
`source("Functions/getIndividualPlayerTables.R")`  

The function requires the paths to the files. Here, I'm within the directory with the HTMLs.   
`playerHTMLs = list.files()`

Run the function.  
`allPlayerList = getIndividualPlayerTables(playerHTMLs)`  

The data table of each player is in a list. Thus, for example, obtain the first 2 weeks of data.  
`allPlayerWk1_2 = lapply(allPlayerList, function(x) x[1:2,])`

## Fitting GLMs to each variable

Here, I assume the count of each variable/statistic (goal, assists, etc) is poisson distributed, and will fit a GLM to each one for each player using the previous weeks data. I use the fits to look at the probability of the counts for each variable.  

To make things shorter, I will only look at Liverpool teams in this example (the row with @CRY in the OPP column of the player data table).  
`playersWanted = row.names(do.call(rbind, lapply(allPlayerWk1_2, function(x) grep("@CRY", x[, "OPP"]))))`  
`playersLiverpool = allPlayerWk2[ playersWanted ]`  

Then fit the GLMs.  
`pLGLMs = fitAllStatPoissonGLMs(playersLiverpool)`  

Then use the lattice package to make barplots for each player.  
`plotAllPlayerDistributions(pLGLMs)`  


