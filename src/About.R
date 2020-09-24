About.ui = function() {
  mainPanel(h1("About"),
            uiOutput("logged_in"),
            uiOutput("content"))
}
About.event_handler = function(input, output, session, cognitomod) {
  observeEvent(cognitomod$isLogged, {
    if (cognitomod$isLogged) {
      # User is logged
      userdata <- cognitomod$userdata
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
