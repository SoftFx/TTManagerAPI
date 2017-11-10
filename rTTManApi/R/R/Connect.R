#' Initialize the CLR runtime and loads QuoteHistory host assembly
#'
ttmInit <- function() {
  require(rClr)
  if(!require(stringi))
  {
    install.packages("stringi")
    require(stringi)
  }
  if(!require(properties))
  {
    install.packages("properties")
    require(properties)
  }
  if(!require(data.table))
  {
    install.packages("data.table")
    require(data.table)
  }
  fileName <-system.file("data", "rTTManApi.dll", package="rTTManApi")
  clrLoadAssembly(fileName)
}
#' Connects to a TT server
#'
#' @param address Url of the server
#' @param login account you login
#' @param password password of the account
#' @param file when not empty, credentials will be read from it
#' @export
ttmConnect <- function(address = "",login = "",password = "", file = "") {
  ttmInit()
  if(nchar(file)!=0)
  {
    configFilePath = file.path(getwd(),file)
    data = read.properties(configFilePath)
    address = data$server
    login = data$login
    password = data$password
  }
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Connect', address, login,password)
  if(hResult != 0) stop('Unable to connect')
}


#' Disconnect from a TT server
#'
#' @export
ttmDisconnect <- function() {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Disconnect')
}
