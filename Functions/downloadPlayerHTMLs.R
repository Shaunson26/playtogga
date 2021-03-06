downloadPlayerHTMLs <- function(login = NULL, password = NULL, playerNameURL, 
                                loginWait = 5, port = 4444L, browser = "firefox"){
  
  if(class(login) != "character") stop("login requires a character string")
  if(class(password) != "character") stop("password requires a character string")
  #if(class(playerNameURL) != "matrix") stop("playerNameURL should be a matrix with at least one column player \"Name\" (P. Layer) and 1 column plauer \"URL\" (epl/players/xxx)")
  
  require(RSelenium)
  
  # Check and start servers for Selenium
  message("If running RSelenium for first time, downloading of extra files may take a few minutes.")
  
  rD <- rsDriver(port = port, browser = browser)
  
  message("Navigating to playtogga.com ...")
  rD$client$navigate("http://www.playtogga.com")
  message("Logging in ...")
  loginButton = rD$client$findElement("class", "login")
  loginButton$clickElement()
  loginButton$sendKeysToElement(list(key = "tab",key = "tab",key = "tab"))
  loginButton$sendKeysToElement(list(login, key = "tab", password, key = "enter"))
  
  Sys.sleep(loginWait)
  if(class(try(rD$client$findElement("class", "postLogin"))) == "try-error"){
    rD$client$quit()
    rm(rD)
    stop("\n Login failed. If your are sure it is correct, increase the loginWait time.")
  }
  
  message("Downloading HTMLs.. This may take a while..")
   for(i in 1:nrow(playerNameURL)){
     #if(i == 1){ dir.create() } # TO DO
    urlIn = paste("https://www.playtogga.com/", playerNameURL[i, "URL"], sep = "")
    rD$client$navigate(urlIn)
    Sys.sleep(3)
    htmlIn = rD$client$getPageSource()[[1]]
    fileName = paste(playerNameURL[i, "Name"],".html", sep = "")
    writeLines(htmlIn, fileName)
}

rD$client$quit()
rm(rD)
message("Done ...")
}