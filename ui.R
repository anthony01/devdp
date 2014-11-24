library(shiny)
load("tab.RData")

shinyUI(pageWithSidebar(
        headerPanel("Example plot"),
        sidebarPanel(
                selectInput("country", "Choose country:", 
                            choices = set.country),
                
                selectInput("period", "Choose a period:", 
                            choices = set.period),
                
                sliderInput("income",
                            "Income:",
                            min = 1,
                            max = 200000,
                            value = 4000)
#                 sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05,)
        ),
        mainPanel(
                plotOutput('newPlot')
        )
))