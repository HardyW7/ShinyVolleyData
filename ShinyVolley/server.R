library(shinydashboard)
library(dplyr)

data <- read.csv("data/volleyball_data.csv") 

# Define the server function
server <- function(input, output, session) {
  output$setter_selector <- renderUI(selectInput("setter_selector", "Setter", unique(data$Setter), multiple = TRUE))
  output$xkill_slider <- renderUI(sliderInput("xkill_slider", "xKill", min = 0, max = 1, value = c(0, 1), step = 0.01))
  output$phase_selector <- renderUI(selectInput("phase_selector", "Phase", unique(data$Phase), multiple = TRUE))
  output$mb_route_selector <- renderUI(selectInput("mb_route_selector", "MB Route", unique(data$Route), multiple = TRUE))
  output$froh_selector <-  renderUI(selectInput("froh_selector", "FR OH", unique(data$FROH), multiple = TRUE))
  output$frmb_selector <-  renderUI(selectInput("frmb_selector", "FR MB", unique(data$FRMB), multiple = TRUE))
  output$frsopp_selector <-  renderUI(selectInput("frsopp_selector", "FR S/OPP", unique(data$FRSOPP), multiple = TRUE))
  output$broh_selector <-  renderUI(selectInput("broh_selector", "BR OH", unique(data$BROH), multiple = TRUE))
  output$brsopp_selector <-  renderUI(selectInput("brsopp_selector", "BR S/OPP", unique(data$BRSOPP), multiple = TRUE))
  output$rotation_selector <-  renderUI(selectInput("rotation_selector", "Rotation", unique(data$Rotation), multiple = TRUE))
  output$match_selector <- renderUI(selectInput("match_selector", "Select Matches", choices = unique(data$Match), multiple = TRUE))

  filtered_data <- reactive({
    data %>%
      filter(
        if (!is.null(input$setter_selector)) Setter == input$setter_selector else TRUE,
        xKill >= input$xkill_slider[1],
        xKill <= input$xkill_slider[2],
        if (!is.null(input$phase_selector)) Phase == input$phase_selector else TRUE,
        if (!is.null(input$mb_route_selector)) Route == input$mb_route_selector else TRUE,
        if (!is.null(input$froh_selector)) FROH == input$froh_selector else TRUE,
        if (!is.null(input$frmb_selector)) FRMB == input$frmb_selector else TRUE,
        if (!is.null(input$frsopp_selector)) FRSOPP == input$frsopp_selector else TRUE,
        if (!is.null(input$broh_selector)) BROH == input$broh_selector else TRUE,
        if (!is.null(input$brsopp_selector)) BRSOPP == input$brsopp_selector else TRUE,
        if (!is.null(input$rotation_selector)) Rotation == input$rotation_selector else TRUE,
        if (!is.null(input$match_selector)) Match %in% input$match_selector else TRUE
      )
  })
  
  filtered_data_update <- eventReactive(input$update_btn, {
    filtered_data()
  })
  
  output$table <- renderDataTable(filtered_data_update())
}
