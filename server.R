ShowPosition <- function(income, tab) {
        
        len.s <- nrow(tab.s)
        i     <- 1
        low   <- 0
        if (income > tab.s$cutoff[len.s]) {
                low <- 0.99
        } else {
                while (i <= len.s & income > tab.s$cutoff[i]) {
                        low <- tab.s$percentile[i] 
                        i   <- i + 1
                }
        }
        return(low)
}

load("tab.RData") # tab, set.country, set.period
income <- 2000
state  <- "Bulgaria"
period <- 2011
tab.s  <- subset(tab, (year == period & country == state), select = c(cutoff, percentile))

if (anyNA(tab.s$cutoff)){

        print ("No data on this country for that period")
}else{
        pos <- ShowPosition(income, tab.s)
        print(pos)
}

library(shiny)

shinyServer(
        function(input, output) {
                output$newPlot <- renderPlot({
                        plot(tab.s$cutoff ~ tab.s$percentile, xlab = "Percentile", ylab = "Income")
                        income   <- input$income
                        country <- input$country
                        period   <- input$period
                        lines(c(0, 1), c(income, income), col = "red", lwd = 5)
                        text(63, 150, paste("country = ", country))
                        text(63, 140, paste("   year = ", period))
                })
        }
)