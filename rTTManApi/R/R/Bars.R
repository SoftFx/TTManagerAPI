
#' Get Bars History
#' @param symbol a character. Symbol name
#' @param periodicity a character. Bar periodicity
#' @param barType a character. Ask or Bid
#' @param endTime a DateTime object. End time
#' @param count a numeric. Integer ticks count (Can be positive or negative)
#' @examples 
#' ttmGetTicks("EURUSD", ISOdatetime(2019,06,05,0,00,00, tz ="GMT"), -100)
#' 
#' @export
ttmGetBarHistory <- function(symbol, periodicity, barType, endTime, count) {
  type <- -1
  if(is.element(barType, names(BarType))){
    type <- BarType[[barType]]
  }else{
    stop(paste("ttmGetBarHistory - Wrong Bar Type -", barType))
  }
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBarHistory', symbol, periodicity, type, endTime, count)
  GetBarHistoryFrame()
}

GetBarHistoryFrame <- function(){
  data.table(
    Timestamp = GetBarsHistoryTimestamps(),
    Open = GetBarsHistoryOpen(),
    High = GetBarsHistoryHigh(),
    Low = GetBarsHistoryLow(),
    Close = GetBarsHistoryClose(),
    Volume = GetBarsHistoryVolume()
  )
}

GetBarsHistoryTimestamps <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBarsHistoryTimestamps')
}

GetBarsHistoryOpen <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBarsHistoryOpen')
}

GetBarsHistoryHigh <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBarsHistoryHigh')
}

GetBarsHistoryLow <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBarsHistoryLow')
}

GetBarsHistoryClose <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBarsHistoryClose')
}

GetBarsHistoryVolume <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBarsHistoryVolume')
}

BarType <- list("Bid" = 0,
                "Ask" = 1
                )

# StoragePerodicity <- list(
#   "TicksLevel2" = 0,
#   "Ticks" = 1,
#   "M1" = 2,
#   "H1" = 3,
#   "VWAP" = 4
# )
