library(shiny)
library(DT)
library(cognitoR)
library(ggplot2)
library(dplyr)
source('src/Auth.R')
source('src/About.R')
source('src/Datasets.R')
source('src/Analysis.R')
shinyApp(
  ui = function() {
    mainPanel(navbarPage(
      "Biebs",
      tabPanel("About", About.ui()),
      tabPanel("Datasets", Datasets.ui()),
      tabPanel("Analysis", Analysis.ui()),
      tabPanel(logout_ui("logout")),
      tags$li(class = "dropdown",
              cognito_ui("cognito"))
    ))
  },
  server = function(input, output, session) {
    cognitomod <- Auth.server(input, output, session)
    About.event_handler(input, output, session, cognitomod)
    Datasets.event_handler(input, output, session, cognitomod)
    Analysis.event_handler(input, output, session, cognitomod)
  }
)
