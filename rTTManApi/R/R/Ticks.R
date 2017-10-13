#' Upstream symbol ticks
#'
#' @export
ttmUpstream <- function(symbol, from, to) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Upstream',symbol,from,to)
}

#' Delete symbol ticks
#'
#' @export
ttmDeleteSymbolTicks <- function(symbol, fromTime, fromIndex, toTime, toIndex) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'DeleteSymbolTicks', symbol, fromTime, fromIndex, toTime, toIndex)
}