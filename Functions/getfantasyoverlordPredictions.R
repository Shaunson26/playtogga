#library(RSelenium)
#library(XML)
#
#rD <- rsDriver(port = 4444L, browser = "firefox")
#rD$client$navigate("https://fantasyoverlord.com/FPL/PlayerPointForecasts")
#retrieveAll = rD$client$findElements("class", "col-md-12")
#retrieveAll[[5]]$clickElement()
#Sys.sleep(10)
#htmlIn = rD$client$getPageSource()[[1]]
#tableIn <- readHTMLTable(htmlIn)[[1]]

## Just want first 3 plus value
#currentValue = grep("Price", names(tableIn)) + 1
#tableInShort = tableIn[,c(1:3, currentValue)]
#names(tableInShort) <- c("Player", "Team", "Points", "Value")
#write.csv(tableInShort, "test.csv")
