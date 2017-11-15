#' Upstream symbol ticks
#' @param symbol a character. Symbol
#' @param from a DateTime object. Start time to upstream 
#' @param to a DateTime object. End time to upstream
#' 
#' @export
ttmUpstream <- function(symbol, from, to) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Upstream',symbol,from,to)
}

#' Delete symbol ticks
#' @param symbol a character. Symbol
#' @param fromTime a DateTime object. Start time to delete 
#' @param fromIndex a double. Start index to delete. By default, fromIndex = 0
#' @param toTime a DateTime object. End time to delete.
#' @param toIndex a double. End index to delete. By default, toIndex = 0
#' 
#' @export
ttmDeleteSymbolTicks <- function(symbol, fromTime, fromIndex, toTime, toIndex) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'DeleteSymbolTicks', symbol, fromTime, fromIndex, toTime, toIndex)
}

#' Upload symbol ticks
#' @param symbol Symbol
#' @param timestamps a DateTime array. Datetimes
#' @param bidPrices a a double array. Bid prices
#' @param bidVolumes a double array. Bid volumes
#' @param askPrices a double array. Ask prices
#' @param askVolumes a double array. Ask volumes
#' 
#' @export
ttmInsertTicks <- function(symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertTicks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes)
}

#' Upload symbol ticks L2
#' @param symbol Symbol
#' @param timestamps a DateTime array. Datetimes
#' @param bidPrices a double array. Bid prices
#' @param bidVolumes a double array. Bid volumes
#' @param askPrices a double array. Ask prices
#' @param askVolumes a double array. Ask volumes
#' @param depth a double array. Depths
#' 
#' @export
ttmInsertLevel2Ticks <- function(symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes, depth) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'InsertLevel2Ticks',symbol, timestamps, bidPrices, bidVolumes, askPrices, askVolumes, depth)
}