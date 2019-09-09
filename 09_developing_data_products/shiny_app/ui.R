library(shiny)

ui <- fluidPage(
    titlePanel("Where you should start your company"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Cost of living sensitivity",
                        min = 1,
                        max = 100,
                        value = 1)
        ),
        mainPanel(
            plotOutput("distPlot")
        )
    ),
    fluidRow(
               h3("Documentation"),
               helpText("This tool helps new companies determine which city to operate in. It reports a score based on the following formula: \n city_patenting_activity / city_cost_of_living ^ cost_of_living_sensitivity.")
    )
    )
