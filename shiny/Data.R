Data.ui = function () {
  sidebarLayout(
    sidebarPanel(
      fileInput(
        "file1",
        "Choose CSV File",
        accept = c(
          "text/csv",
          "text/comma-separated-values,text/plain",
          ".csv"
        )
      ),
      tags$hr(),
      checkboxInput("header", "Header", TRUE)
    ),
    mainPanel(
      DT::dataTableOutput('listtab'),
      DT::dataTableOutput('datatab'),
      verbatimTextOutput('printMsg')
    )
    
  )
}
Data.event_handler = function(input, output, session, auth, project) {
  observe({
        # Trigger this observer every time an input changes
        reactiveValues(file=input$file1)
       # session$doBookmark()
      })
  onBookmarked(function(url) {
   #     updateQueryString(url)
    state$values$currentSum <- 'foo'
      })
  #onBookmark(function(state) {
  #})
  dataset = reactiveValues()
  dataset$Data <- data.table()
  vals = reactiveValues()
  observeEvent(auth$isLogged, {
    if (auth$isLogged) {
      # User is logged
      
      datasetlist <- data.table(Db.list('datasets',auth$userdata$username))
      Action = buttonInput(
        FUN = actionButton,
        len = nrow(datasetlist),
        id = 'button_',
        label = "Delete",
        onclick = 'Shiny.onInputChange(\"lastClick\",  this.id)'
      )
      datasetlist$Action <- Action
      vals$Data <- datasetlist
      output$listtab <- DT::renderDataTable({
        DT = vals$Data
        datatable(DT, escape = F)
      })
      
    }
    
  })
  output$datatab <- DT::renderDataTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
      name = strsplit(inFile$name, '[.]')[[1]][1]
    obj <- read.csv(inFile$datapath, header = input$header)
    Db.save(
      collection='datasets',
      user = auth$userdata$username,
      object = obj,
      name = name
    )
    return(obj)
  })
  
  printText <- reactiveValues(names = '')
  
  buttonInput <- function(FUN, len, id, ...) {
    inputs <- character(len)
    for (i in seq_len(len)) {
      inputs[i] <- as.character(FUN(paste0(id, i), ...))
    }
    inputs
  }
  
  
  observeEvent(input$listtab_rows_selected, {
    filename <- vals$Data[input$listtab_rows_selected, 1][[1]][[1]]
    name <- vals$Data[input$listtab_rows_selected, 2][[1]][[1]]
    printText$names <<-
      paste('clicked on', filename)
  dataset$name <- name
  dataset$Data <- data.table(Db.load(filename))
  })
  
  
  observeEvent(input$lastClick, {
    selectedRow <- as.numeric(strsplit(input$lastClick, "_")[[1]][2])
    filename <- vals$Data[selectedRow, 3][[1]]
    printText$names <<-
      paste('deleted ', filename)
  })
  output$printMsg <- renderText({
    printText$names
  })
  
  
 return(dataset) 
}
