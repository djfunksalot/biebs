Auth.authTab = function() {
  logout_ui("logout")
}
Auth.server = function (input, output, session) {
  cognitomod <- callModule(cognito_server, "cognito")
  logoutmod <- callModule(
    logout_server,
    "logout",
    reactive(cognitomod$isLogged),
    sprintf("user: '%s'", cognitomod$userdata$email)
  )
  observeEvent(logoutmod(), {
    cognitomod$logout()
  })
  # Check if user is logged in, show content
  observeEvent(cognitomod$isLogged, {
    if (cognitomod$isLogged) {
      userdata <- cognitomod$userdata
      attr(session$userData, "auth") <- userdata
      attr(session$userData, "cognitomod") <- cognitomod
    }
  })
  return(cognitomod)
}
