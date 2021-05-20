#' Gets All Dividends
#'
#' @examples 
#' ttmGetAllDividends()
#' @export
ttmGetAllDividends <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDividends')
  GetAllDividendFrame()
}
# Get All Dividend Table
GetAllDividendFrame <- function(){
  Id = GetAllDividendsId()
  Timestamp = GetAllDividendsTimestamp()
  Symbol = GetAllDividendsSymbol()
  GrossRate = GetAllDividendsGrossRate()
  Fee = GetAllDividendsFee()
  data.table(Id, Timestamp, Symbol, GrossRate, Fee)
}
# Get All Dividend field
GetAllDividendsId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDividendsId')
}
# Get All Dividend field
GetAllDividendsTimestamp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDividendsTimestamp')
}
# Get All Dividend field
GetAllDividendsSymbol<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDividendsSymbol')
}
# Get All Dividend field
GetAllDividendsGrossRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDividendsGrossRate')
}
# Get All Dividend field
GetAllDividendsFee<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDividendsFee')
}
