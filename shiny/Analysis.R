df <- mtcars
fields <- colnames(df)
Analysis.ui = function() {
            sidebarLayout(
              sidebarPanel(
                DT::dataTableOutput('analysistab'),
                downloadButton("downloadData", "Download")
              ),
              mainPanel(
                verbatimTextOutput("summary"),
                plotOutput('x2', height = 500)
              )
            )
}

Analysis.event_handler = function(input, output, session, auth, project, dataset) {
  observeEvent(auth$isLogged, {
    if (auth$isLogged) {
      # User is logged
      userdata <- auth$userdata
    }
  })
  output$summary <- renderPrint({
    summary(dataset$Data)
  })
  
#  # a large table, reative to input$show_vars
  output$analysistab <- renderDT(
    dataset$Data,
    filter = "top",
    options = list(
      pageLength = 10,
      scrollX = TRUE,
      scrollY = TRUE,
      sDom  = '<"top">flrt<"bottom">ip'
    )
  )
  output$x2 = renderPlot({
    s = input$analysistab_rows_selected
    trimmed<-dataset$Data  %>% select(c(dataset$X_cols,dataset$Y_cols))
    par(mar = c(4, 4, 1, .1))
    plot(trimmed)
    if (length(s))
      points(trimmed[s, , drop = FALSE], pch = 19, cex = 2)
 })
#  output$x4 = renderPrint({
#    s = input$x3_rows_selected
#    if (length(s)) {
#      cat('These rows were selected:\n\n')
#      cat(s, sep = ', ')
#    }
#  })
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(dataset$Data, file)
    }
  )
}
