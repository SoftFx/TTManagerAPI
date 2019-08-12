# #' Upstream symbol ticks
# #' @param symbol a character. Symbol
# #' @param from a DateTime object. Start time to upstream
# #' @param to a DateTime object. End time to upstream
# #' @param upstreamType a numeric. UpstreamType Enum Code
# #' @examples
# #'  ttmUpstream("EURUSD", ISOdatetime(2017,08,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,02,0,00,00, tz ="GMT"), 1)
# ttmUpstream <- function(symbol, from, to, upstreamType) {
#   hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'Upstream', symbol, from, to, upstreamType)
#   if(hResult == FALSE) stop("ttmUpstream return false")



#' UpstreamAsync symbol ticks
#' @param symbol a character vector. Symbol names
#' @param from a DateTime object. Start time to upstream 
#' @param to a DateTime object. End time to upstream
#' @param upstreamType a character vector. From this ("Level2ToTicks","TicksToM1","M1ToH1","Level2ToVWAP","Level2ToMain","TicksToCache" ,"M1ToCache","H1ToCache" ,"Cache","Level2ToAll")
#' @examples 
#'  ttmUpstreamAsync("EURUSD", ISOdatetime(2017,08,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,02,0,00,00, tz ="GMT"), c("M1ToH1", "H1ToCache"))
#' 
#' @export
ttmUpstreamAsync <- function(symbol, from, to, upstreamType) {
  upstreamNum <- sapply(1:length(upstreamType), function(i){
    if( is.element(upstreamType[i], names(UpstreamTypes))){
      UpstreamTypes[[upstreamType[i]]]
    }else{
      stop(paste("ttmUpstreamAsync - Wrong Upstream Type -", upstreamType[i]))
      -1
    }
  })
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'UpstreamAsync', symbol, from, to, upstreamNum)
  hResult
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

#' Upload Quotes
#' @param symbol a character. Symbol name
#' @param periodicityLevel a character. Periodicity Level. From this ("TicksLevel2", "Ticks" ,"M1", "H1", "VWAP")
#' @param fullFilePath a character. Path to Zip Quote File
#' @examples 
#' ttmUploadQuotes("EURUSD", "M1", "C:/Quotes/EURUSD_Ticks_2019-05-24_2019-06-01.zip")
#' 
#' @export
ttmUploadQuotes <- function(symbol, periodicityLevel, fullFilePath) {
  periodicity <- -1
  if(is.element(periodicityLevel, names(StoragePerodicity))){
    periodicity <- StoragePerodicity[[periodicityLevel]]
  }else{
    stop(paste("ttmUploadQuotes - Wrong Storage Type -", periodicityLevel))
  }
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'UploadQuotes', symbol, periodicity, fullFilePath)
  hResult
}

#' Export Quotes
#' @param symbol a character vector. Symbol names
#' @param from a DateTime object. Start time to export
#' @param to a DateTime object. End time to export
#' @param periodicityLevel a character. Periodicity Level. From this ("TicksLevel2", "Ticks" ,"M1", "H1", "VWAP")
#' @param resultDirPath a character. Path to directory where quotes will be downloaded.
#' @param isLocalDownload a bool. Download File to Local Machine or not
#' @examples 
#' ttmExportQuotes(c("EURUSD"), ISOdatetime(2019,06,05,0,00,00, tz ="GMT"), ISOdatetime(2019,06,06,0,00,00, tz ="GMT"), "M1", "C:/Quotes", TRUE)
#' 
#' @export
ttmExportQuotes <- function(symbol, from, to, periodicityLevel, resultDirPath, isLocalDownload = FALSE) {
  periodicity <- -1
  if(is.element(periodicityLevel, names(StoragePerodicity))){
    periodicity <- StoragePerodicity[[periodicityLevel]]
  }else{
    stop(paste("ttmExportQuotes - Wrong Storage Type -", periodicityLevel))
  }
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'ExportQuotes',symbol, from, to, periodicity, resultDirPath, isLocalDownload)
  hResult
}

#' Delete Quotes
#' @param symbol a character vector. Symbol names
#' @param from a DateTime object. Start time to delete
#' @param to a DateTime object. End time to delete
#' @param periodicityLevel a character. Periodicity Level. From this ("TicksLevel2", "Ticks" ,"M1", "H1", "VWAP")
#' @examples 
#' ttmExportQuotes(c("EURUSD"), ISOdatetime(2019,06,05,0,00,00, tz ="GMT"), ISOdatetime(2019,06,06,0,00,00, tz ="GMT"), "M1", "C:/Quotes", TRUE)
#' 
#' @export
ttmDeleteQuotes <- function(symbol, from, to, periodicityLevel) {
  periodicity <- -1
  if(is.element(periodicityLevel, names(StoragePerodicity))){
    periodicity <- StoragePerodicity[[periodicityLevel]]
  }else{
    stop(paste("ttmDeleteQuotes - Wrong Storage Type -", periodicityLevel))
  }
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'DeleteFromStorageAsync',symbol, from, to, periodicity)
  hResult
}

#' Get Quotes
#' @param symbol a character. Symbol name
#' @param to a DateTime object. End time
#' @param count a numeric. Integer ticks count (Can be positive or negative)
#' @examples 
#' ttmGetTicks("EURUSD", ISOdatetime(2019,06,05,0,00,00, tz ="GMT"), -100)
#' 
#' @export
ttmGetTicks <- function(symbol, endTime, count) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTicks', symbol, endTime, count)
  GetTicksFrame()
}

GetTicksFrame <- function(){
  data.table(
    Timestamp = GetTicksTimestamps(),
    BidPrice = GetTicksBidPrice(),
    BidVolume = GetTicksBidVolume(),
    AskPrice = GetTicksAskPrice(),
    AskVolume = GetTicksAskVolume()
  )
}

GetTicksTimestamps <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTicksTimestamps')
}

GetTicksAskPrice <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTicksAskPrice')
}

GetTicksAskVolume <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTicksAskVolume')
}

GetTicksBidPrice <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTicksBidPrice')
}

GetTicksBidVolume <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTicksBidVolume')
}


UpstreamTypes <- list("Level2ToTicks" = 1,
                      "TicksToM1" = 2,
                      "M1ToH1" = 4,
                      "Level2ToVWAP" = 8,
                      "Level2ToMain" = 15,
                      "TicksToCache" = 16,
                      "M1ToCache" = 32,
                      "H1ToCache" = 64,
                      "Cache" = 112,
                      "Level2ToAll" = 127)

StoragePerodicity <- list(
  "TicksLevel2" = 0,
  "Ticks" = 1,
  "M1" = 2,
  "H1" = 3,
  "VWAP" = 4
)
