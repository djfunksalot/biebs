library(shiny)
library(shinyjs)
library(DT)
library(data.table)
library(ggplot2)
library(dplyr)
library(mongolite)
source('Auth.R')
source('Db.R')
source('About.R')
source('Projects.R')
source('Data.R')
source('Analysis.R')
enableBookmarking("url")
#Main UI.  Load Panels in order panel_order=c('About','Project','Data','Prep','Analysis')
shinyApp(
  ui = function() {
    fluidPage(title = 'Data Analysis Framework',
    mainPanel(navbarPage(
      "Biebs",
      tabPanel("About", About.ui()),
      tabPanel("Data", Data.ui()),
      tabPanel("Project", Projects.ui()),
      tabPanel("Analysis", Analysis.ui()),
      tabPanel(logout_ui("logout")),
      tags$li(class = "dropdown",
              cognito_ui("cognito"))
    ),
    mainPanel(
        DT::dataTableOutput("maintable"),
    ),
))
  },
  server = function(input, output, session) {
    auth <- Auth.event_handler(input, output, session)
    dataset<-Data.event_handler(input, output, session, auth)
    project<-Projects.event_handler(input, output, session, auth, dataset)
    Analysis.event_handler(input, output, session, auth, project, dataset)
    About.event_handler(input, output, session, auth, project, dataset)
  }
)
