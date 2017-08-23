# playtogga
Functions and data for scraping/downloading playtogga FPL data.  

# The process
With my limited expertise, I have put together some R functions for scraping the player tables from playtogga. The main scrape function uses RSelenium to run your brower, login, and then use a user-specified file (an updated file of each and every player is provided) that nagivates to the player tables wanted and the HTMLs are saved. Another function extracts and cleans the tables from the HTMLs and puts them into a list in R.

