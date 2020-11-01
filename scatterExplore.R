library(tidyverse)
library(plotly)
library(shiny)

args <- commandArgs(trailingOnly=T)
port <- as.numeric(args[[1]])

data <- read_csv("derivedData/finalData.csv")
variableOptions <- c("Avg. number of mentally unhealthy days" = "mentally_unhealthy_days",
                     "Avg. number of physically unhealthy days" = "physically_unhealthy_days",
                     "Average Daily PM2.5 (Air Quality)" = "air_quality_score_rating",
                     "Food Environment Index" = "food_environment_index",
                     "Percent Poor or Fair Health" = "percent_poor_health",
                     "Life Expectancy (years)" = "life_expectancy",
                     "Avg. Percent Physical Distress" = "percent_physical_distress",
                     "Avg. Percent Mental Distress" = "percent_mental_distress")

ui <- fluidPage(
  titlePanel("Allowable CAFO Count in North Carolina"),
  sidebarLayout(
    sidebarPanel(div("How does the number of allowable CAFOs in each
                     county in NC affect that county's health?"),
                 selectInput(inputId="variable",
                             label="Choose a health variable to compare:",
                             choices=c("physically_unhealthy_days",
                                       "mentally_unhealthy_days",
                                       "air_quality_score_rating",
                                       "food_environment_index",
                                       "percent_poor_health",
                                       "life_expectancy",
                                       "percent_physical_distress",
                                       "percent_mental_distress"),
                             selected="Avg. number of mentally unhealthy days")
    ),
    mainPanel(
      plotlyOutput("scatterPlot")
    )
  )
)

server <- function(input, output) {
  output$scatterPlot <- renderPlotly({
    
    ggplotly(ggplot(data, aes(x = allowable_count, y = get(input$variable))) + 
               geom_point(color = "darkorchid1", alpha = 0.35) + 
               geom_smooth(method='lm') + 
               labs(title = "Mentally Unhealthy Days vs Allowable CAFO Count", 
                    x="Allowable Count", y=names(variableOptions[which(variableOptions==input$variable)])))
  })
}

print(sprintf("Starting shiny on port %d", port))
shinyApp(ui=ui, server=server, options=list(port=port, host="0.0.0.0"))