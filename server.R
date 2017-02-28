library(shiny)
library(plotly)

# Define server logic required to plot gains/losses of five investment sectors
shinyServer(function(input, output) {
  
  # Define a data.frame with quotes within the date range specified
  subQuotesDF <- reactive({
    
    quotesDF <- read.table("quotesDF", sep=",", header=TRUE)
    
    quotesDF$date <- as.Date(quotesDF$date)
    
    startDate <- as.Date(input$date1)
    endDate <- as.Date(input$date2)
    
    # Pull out a subset of each column
    subDate <- quotesDF$date[quotesDF$date>=startDate & quotesDF$date<=endDate]
    
    SPX <- quotesDF$spx[quotesDF$date>=startDate & quotesDF$date<=endDate]
    spx <- 100.0*(SPX-SPX[1])/SPX[1]
    
    GLD <- quotesDF$gld[quotesDF$date>=startDate & quotesDF$date<=endDate]
    gld <- 100.0*(GLD-GLD[1])/GLD[1]
    
    OIL <- quotesDF$oil[quotesDF$date>=startDate & quotesDF$date<=endDate]
    oil <- 100.0*(OIL-OIL[1])/OIL[1]
    
    O <- quotesDF$o[quotesDF$date>=startDate & quotesDF$date<=endDate]
    o <- 100.0*(O-O[1])/O[1]
    
    BND <- quotesDF$bnd[quotesDF$date>=startDate & quotesDF$date<=endDate]
    bnd <- 100.0*(BND-BND[1])/BND[1]
    
    subSetDF <- data.frame(date=subDate, spx=spx, gld=gld, oil=oil, o=o, bnd=bnd)
    
  })
  
  # Create a line plot for gains/losses of the five sectors
  output$investPlot <- renderPlot ({

    # Determine the top margin of the plot
    maxQuote <- max(max(subQuotesDF()$spx), max(subQuotesDF()$gld), max(subQuotesDF()$oil), 
                    max(subQuotesDF()$o), max(subQuotesDF()$bnd))
    if (maxQuote > 0)  {maxLimit = 1.1*maxQuote}
    else  {maxLimit = 0.9*maxQuote}
    
    # Determine the bottom margin of the plot
    minQuote <- min(min(subQuotesDF()$spx), min(subQuotesDF()$gld), min(subQuotesDF()$oil), 
                    min(subQuotesDF()$o), min(subQuotesDF()$bnd))
    if (minQuote < 0)  {minLimit = 1.1*minQuote}
    else  {minLimit = 0.9*minQuote}
    
    
    plot(subQuotesDF()$date, subQuotesDF()$spx, col="blue", type="l", 
         xlab="Date", ylab="Percent Change", ylim=c(minLimit, maxLimit), 
         sub="[NOTE: The red vertical line marks 2009-03-09, the lowest point for the S&P 500]")
    lines(subQuotesDF()$date, subQuotesDF()$gld, col="orange")
    lines(subQuotesDF()$date, subQuotesDF()$oil, col="black")
    lines(subQuotesDF()$date, subQuotesDF()$o, col="green")
    lines(subQuotesDF()$date, subQuotesDF()$bnd, col="brown")
    abline(h=0, col="black", lwd=2)
    # Mark the date of the bottom of the recession 
    #(i.e., lowest point for the S&P 500)
    abline(v=as.Date("2009-03-09"), col="red")
    legend("topleft",legend=c("S&P 500", "Gold", "Oil", "Realty", "Bonds"), 
           col=c("blue", "orange", "black", "green", "brown"), lty=1, cex=0.8)
  })
  
  output$dateRange <- renderText({
    paste("Over the date range", input$date1, "to", input$date2)
  })
  
  output$spxText <- renderText({
    paste("  The gain/loss on S&P 500 = ", 
          round(subQuotesDF()$spx[length(subQuotesDF()$spx)],2), "%", sep="")
  })
  
  output$gldText <- renderText({
    paste("  The gain/loss on gold = ", 
          round(subQuotesDF()$gld[length(subQuotesDF()$gld)],2), "%", sep="")
  })
  
  output$oilText <- renderText({
    paste("  The gain/loss on crude oil = ", 
          round(subQuotesDF()$oil[length(subQuotesDF()$oil)],2), "%", sep="")
  })

  output$oText <- renderText({
    paste("  The gain/loss on real estate = ", 
          round(subQuotesDF()$o[length(subQuotesDF()$o)],2), "%", sep="")
  })

  output$bndText <- renderText({
    paste("  The gain/loss on the bond market = ", 
          round(subQuotesDF()$bnd[length(subQuotesDF()$bnd)],2), "%", sep="")
  })
  
})
