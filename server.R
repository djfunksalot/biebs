library(shiny)
library(ggplot2)
##
shinyServer(function(input, output) {

  Data <- reactive({
    if(input$radio == "All"){
      df
    } else {
      df[,input$show_vars,drop=FALSE]
    }

  })
  output$summary <- renderPrint({
    dataset <- Data()
    summary(dataset)
  })

  # a large table, reative to input$show_vars
        output$x1 <- renderDT(Data(),
                                 filter = "top",
                                 options = list(
                                     pageLength = 10,
                                     scrollX = TRUE,
                                     scrollY = TRUE
                                 )
        )
  output$x2 = renderPlot({
    s = input$x1_rows_selected
    par(mar = c(4, 4, 1, .1))
    plot(Data()[1:2])
    if (length(s)) points(Data()[1:2][s, , drop = FALSE], pch = 19, cex = 2)
  })


 output$x4 = renderPrint({
    s = input$x3_rows_selected
    if (length(s)) {
      cat('These rows were selected:\n\n')
      cat(s, sep = ', ')
    }
  })
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(Data(), file)
    }
  )


})
