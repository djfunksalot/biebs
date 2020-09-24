About.ui = function() {
  mainPanel(h1("About"),
            uiOutput("logged_in"),
            uiOutput("content"))
}
About.event_handler = function(input, output, session, auth, project, dataset) {
  observeEvent(auth$isLogged, {
    if (auth$isLogged) {
      # User is logged
      userdata <- auth$userdata
      
      # Render user logged.
      output$logged_in <- renderUI({
        p(paste0("Welcome ", unlist(userdata$username),'!'))
      })
    }
  })
      output$content <- renderUI({
        p('You are about to embark on a journey of data exploration')
      })
}
