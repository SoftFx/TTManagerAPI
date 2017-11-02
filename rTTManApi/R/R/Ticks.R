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

#' Upload symbol ticks
#' @param symbol Symbol
#' @param timestamps Array of datetimes
#' @param bidPrices Array of bid prices
#' @param bidVolumes Array of bid volumes
#' @param askPrices Array of ask prices
#' @param askVolumes Array of ask volumes
#' 
#' @export
ttmInsertTicks <- function(symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertTicks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes)
}

#' Upload symbol ticks L2
#' @param symbol Symbol
#' @param timestamps Array of datetimes
#' @param bidPrices Array of bid prices
#' @param bidVolumes Array of bid volumes
#' @param askPrices Array of ask prices
#' @param askVolumes Array of ask volumes
#' @param depth Array of depth
#' 
#' @export
ttmInsertLevel2Ticks <- function(symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes, depth) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertLevel2Ticks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes, depth)
}