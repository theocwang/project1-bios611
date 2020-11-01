library(tidyverse)
library(plotly)
library(shiny)

args <- commandArgs(trailingOnly=T)
port <- as.numeric(args[[1]])

data <- read_csv("derivedData/finalData.csv")

ui <- fluidPage(
  titlePanel("Allowable CAFO Count in North Carolina"),
  sidebarLayout(
    sidebarPanel(div("Throughout the entirety of North Carolina,
                     what is our distribution of counties with
                     or without allowable CAFO counts?"),
                 sliderInput(inputId="bins",
                             label="Number of bins:",
                             min=1,
                             max=50,
                             value=30)
    ),
    mainPanel(
      plotlyOutput("histPlot")
    )
  )
)

server <- function(input, output) {
  output$histPlot <- renderPlotly({
    bins <- input$bins
    
    ggplotly(ggplot(data, aes(x=allowable_count)) + geom_histogram(bins=bins) + 
                      labs(title = "Histogram of Allowable CAFO Counts"))
  })
}

print(sprintf("Starting shiny on port %d", port))
shinyApp(ui=ui, server=server, options=list(port=port, host="0.0.0.0"))