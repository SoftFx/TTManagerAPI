#' Initialize the CLR runtime and loads QuoteHistory host assembly
#'
ttmInit <- function() {
  require(rClr)
  if(!require(stringi))
  {
    install.packages("stringi")
    require(stringi)
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
#' @export
ttmConnect <- function(address = "",login = "",password = "") {
  ttmInit()
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Connect', address, login,password)
  if(hResult != 0) stop('Unable to connect')
}


#' Disconnect from a TT server
#'
#' @export
ttmDisconnect <- function() {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Disconnect')
}
