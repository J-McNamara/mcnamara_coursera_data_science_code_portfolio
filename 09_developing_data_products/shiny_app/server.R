server <- function(input, output) {
    
    library(ggplot2)
    library(shiny)
    library(plotly)
    library(leaflet)
    library(dplyr)
    library(magrittr)
    
    # Load and join data
    cost <- read.csv('cost-living.csv')
    pats <- read.csv('uspto-tidy.csv')
    coords <- read.csv('coords.csv')
    
    df <- merge(cost, pats,by="city", all=TRUE)
    df <- merge(df, coords,by="city", all=TRUE)
    df$comp <- df$patents / (df$cost) #Make composite score
    sorted <- df
    sorted <- df[order(df$comp, decreasing = TRUE),] 
    #sorted <- sorted[1:100,]
    
    output$distPlot <- renderPlot({
        x <- sorted
        x$comp <- NA
        x$comp <- x$patents / (x$cost ^ input$bins)
        x <- x[order(x$comp, decreasing = TRUE),]
        x <- x[1:10,]
        x$comp <- x$comp / x$comp[1]
        
        barplot(x$comp, col = 'red', border = 'white', names.arg = x$city, las=2, xlab = 'City', ylab = 'City favorability score')
    })
}
