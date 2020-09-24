Datasets.ui = function () {
 sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
        accept = c(
          "text/csv",
          "text/comma-separated-values,text/plain",
          ".csv")
        ),
      tags$hr(),
      checkboxInput("header", "Header", TRUE)
    ),
    mainPanel(
      tableOutput("contents")
    )
    
 )
}
Datasets.event_handler = function(input, output, session, cognitomod) {
  observeEvent(cognitomod$isLogged, {
    if (cognitomod$isLogged) {
      # User is logged
      userdata <- cognitomod$userdata
      print(cognitomod$userdata$sub)
    }
  })
  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header)
  })
  
}
