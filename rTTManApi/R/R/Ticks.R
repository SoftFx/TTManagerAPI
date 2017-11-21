#' Upstream symbol ticks
#'
#' @export
ttmUpstream <- function(symbol, from, to) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Upstream',symbol,from,to)
  if(hResult == FALSE) stop("ttmUpstream return false")
}

#' Delete symbol ticks
#'
#' @export
ttmDeleteSymbolTicks <- function(symbol, fromTime, fromIndex, toTime, toIndex) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'DeleteSymbolTicks', symbol, fromTime, fromIndex, toTime, toIndex)
  if(hResult == FALSE) stop("ttmDeleteSymbolTicks return false")
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
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertTicks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes)
  if(hResult == FALSE) stop("ttmInsertTicks return false")
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
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertLevel2Ticks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes, depth)
  if(hResult == FALSE) stop("ttmInsertLevel2Ticks return false")
}