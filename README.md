# DevelopingDataProductsShiny
**Investment Sectors' Gains/Losses Since The Great Recession [shiny project]**

During the 'Great Recession' the stock market dropped to a low on March 9, 2009. Most markets rebounded from these lows in the intervening years. SectorTracker is a shiny app that generates a plot showing the percent gain or percent loss for each of five sectors of the market: the S&P 500, the price of gold, the price of oil, real estate income trusts, and the total bond market. By adjusting the 'Start Date' slider and the 'End Date' slider the user can observe the percent gain/loss of all of these sectors over any date range within the span 2008-01-02 to 2017-02-17. These gains/losses are shown visually in a plot and numerically in the text below the plot. A vertical red line on the plot marks the S&P 500's lowest point on 2009-03-09.

The SectorTracker app contains within it the file quotesDF, a data.frame with the columns:<br>
 - *date* - Dates in the format yyyy-mm-dd ranging from 2008-01-02 to 2017-02-17<br>
 - *spx* - Daily adjusted close* values for the stock index the S&P 500 (^GSPC on finance.yahoo.com)<br>
 - *gld* - Daily adjusted close* values for an exchange traded fund representing physical gold (GLD on finance.yahoo.com)<br>
 - *oil* - Daily adjusted close* values for an exchange traded fund representing crude oil (OIL on finance.yahoo.com)<br>
 - *o* - Daily adjusted close* values for a real estate income trust fund (O on finance.yahoo.com)<br>
 - *bnd* - Daily adjusted close* values for an exchange traded fund representing the total bond market (BND on finance.yahoo.com)<br>
  
&ast; Adjusted close values factor dividends, interest and stock splits into the daily changing price of the equity and were taken from the finance.yahoo.com website by using the R package *quantmod*. 

