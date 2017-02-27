library(shiny)

# Define UI for application that plots the gains/losses for five sectors of the 
# market over a user-defined range of dates
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Investment Sectors' Gains/Losses Since The Great Recession"),
  
  
  sidebarLayout(
    sidebarPanel(

      h4("Dates must fall in the range 2008-01-02  to  2017-02-17"),
      h4(" "), 

      # Use two sliders to establish a range of dates
      sliderInput("date1", "Start Date", as.Date("2008-01-02"), 
                  as.Date("2017-02-17"), as.Date("2009-03-09")),
      sliderInput("date2", "End Date", as.Date("2008-01-02"), 
                  as.Date("2017-02-17"), as.Date("2017-02-17"))  
      
    ), 
    
    mainPanel(
      # Create a line plot of the five sectors gains with the date range
      plotOutput("investPlot"), 
      
      # Display the range of dates being used
      textOutput("dateRange"), 
      
      # Display the gain/loss for each sector over the date range
      textOutput("spxText"), 
      textOutput("gldText"), 
      textOutput("oilText"), 
      textOutput("oText"), 
      textOutput("bndText") 
      
    )
  )
))
