# playtogga
Functions and data for scraping/downloading playtogga FPL data.  

# The process

With my limited expertise, I have put together some R functions for scraping the player tables from playtogga. The main scrape function uses RSelenium to run your brower, login, and then use a user-specified file (an updated file of each and every player is provided) that nagivates to the player tables wanted and the HTMLs are saved. Another function extracts uses the XML package to extract tables from the HTMLs, cleans them and puts them into a list in R.

Poisson GLMs are then fit to each scoring event (goal, assist, successful cross, etc.) of each player using game week as replicates. The likelihood densities of each event given the GLMs are calculated. A range of plotting functions are included using the lattice package.  

The estimated/predicted scores can then be calculated based on quantiles. More plotting functions are provided to examine the predicted scores for a range of quantitles.  

A quick tutorial is shown in `Introduction.html`.

