library(shiny)

shinyUI(fluidPage(
  title = 'Dataframe Filtering and Visualization',
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId="radio",
        label="Variable Selection Type:",
        choices=list(
          "All",
          "Manual Select"
        ),
        selected="Manual Select"),
      conditionalPanel(
        condition = "input.radio != 'All'",
        selectizeInput('show_vars', 'Columns to show:', choices=names(df), 
            selected = list('mpg','wt'), 
            multiple = TRUE,
            options = NULL),
      ),
      plotOutput('x2', height = 500),
      downloadButton("downloadData", "Download")
    ),
    mainPanel(
      verbatimTextOutput("summary"), 
      tabsetPanel(
        id = 'dataset',
        tabPanel('data', DT::dataTableOutput('x1'))
      )
    )
  )
))
