Projects.ui = function () {
mainPanel(
      selectizeInput('colselectX', choices = NULL,label='x', multiple = TRUE),
      selectizeInput('colselectY', choices = NULL,label='y', multiple = TRUE),
      DT::dataTableOutput("projecttab")
    )
}
Projects.event_handler = function(input, output, session, auth, dataset) {
      # User is logged
observeEvent(dataset$name, {
print(dataset$name)

  output$projecttab <- DT::renderDataTable({
   DT = dataset$Data
        datatable(DT, escape = F)
      })
updateSelectizeInput(session, 'colselectX', choices = names(dataset$Data), server = TRUE)
updateSelectizeInput(session, 'colselectY', choices = names(dataset$Data), server = TRUE)
})
observeEvent(input$colselectX, {
dataset$X_cols<-input$colselectX
})
observeEvent(input$colselectY, {
dataset$Y_cols<-input$colselectY
})


  project=list(
    dataset=NULL,
    x=list(),
    y=list()
  )
  return(project)
}
