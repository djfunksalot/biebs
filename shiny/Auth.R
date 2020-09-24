require('cognitoR')
Auth.authTab = function() {
  logout_ui("logout")
}
Auth.event_handler = function (input, output, session) {
  # Check for cognitoR config
  if (!file.exists('config.yml')) {
    print("auth config does not exist.  local user only")
    auth = list()
    auth$userdata = reactiveValues()
    auth$isLogged = TRUE
    auth$userdata$username = 'test'
    return(auth)
  }
  auth <- callModule(cognito_server, "cognito")
  logoutmod <- callModule(
    logout_server,
    "logout",
    reactive(auth$isLogged),
    sprintf("user: '%s'", auth$userdata$email)
  )
  observeEvent(logoutmod(), {
    auth$logout()
  })
  return(auth)
}
