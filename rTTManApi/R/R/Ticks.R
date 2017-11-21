#' Upstream symbol ticks
#' @param symbol a character. Symbol
#' @param from a DateTime object. Start time to upstream 
#' @param to a DateTime object. End time to upstream
#' @examples 
#'  ttmUpstream("EURUSD", ISOdatetime(2017,08,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,02,0,00,00, tz ="GMT"))
#' 
#' @export
ttmUpstream <- function(symbol, from, to) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Upstream',symbol,from,to)
  if(hResult == FALSE) stop("ttmUpstream return false")
}

#' Delete symbol ticks
#' @param symbol a character. Symbol
#' @param fromTime a DateTime object. Start time to delete 
#' @param fromIndex a double. Start index to delete. By default, fromIndex = 0
#' @param toTime a DateTime object. End time to delete.
#' @param toIndex a double. End index to delete. By default, toIndex = 0
#' @examples 
#' ttmDeleteSymbolTicks("EURUSD", ISOdatetime(2017,08,01,0,00,00, tz ="GMT"),0, ISOdatetime(2017,08,02,0,00,00, tz ="GMT"),0)
#' 
#' @export
ttmDeleteSymbolTicks <- function(symbol, fromTime, fromIndex, toTime, toIndex) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'DeleteSymbolTicks', symbol, fromTime, fromIndex, toTime, toIndex)
  if(hResult == FALSE) stop("ttmDeleteSymbolTicks return false")
}

#' Upload symbol ticks
#' @param symbol Symbol
#' @param timestamps a DateTime array. Datetimes
#' @param bidPrices a a double array. Bid prices
#' @param bidVolumes a double array. Bid volumes
#' @param askPrices a double array. Ask prices
#' @param askVolumes a double array. Ask volumes
#' @examples 
#' ttmInsertTicks("EURUSD", c(ISOdatetime(2017,11,01,0,00,00, tz ="GMT"), ISOdatetime(2017,11,01,0,00,02, tz ="GMT")), c(1.20, 1.21), c(100, 1000), c(1.21,1.22), c(1000, 1000))
#' 
#' @export
ttmInsertTicks <- function(symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertTicks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes)
  if(hResult == FALSE) stop("ttmInsertTicks return false")
}

#' Upload symbol ticks L2
#' @param symbol Symbol
#' @param timestamps a DateTime array. Datetimes
#' @param bidPrices a double array. Bid prices
#' @param bidVolumes a double array. Bid volumes
#' @param askPrices a double array. Ask prices
#' @param askVolumes a double array. Ask volumes
#' @param depth a double array. Depths
#' @examples 
#' ttmInsertLevel2Ticks("EURUSD", c(ISOdatetime(2017,11,01,0,00,00, tz ="GMT"), ISOdatetime(2017,11,01,0,00,02, tz ="GMT")), c(1.20, 1.21), c(100, 1000), c(1.21,1.22), c(1000, 1000),c(1, 2))
#' 
#' @export
ttmInsertLevel2Ticks <- function(symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes, depth) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertLevel2Ticks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes, depth)
  if(hResult == FALSE) stop("ttmInsertLevel2Ticks return false")
}