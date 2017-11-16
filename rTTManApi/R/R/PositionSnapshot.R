#' Gets the position snaphots as requested
#' 
#' @param accId a numeric vector. Accounts ids.
#' @param from a POSIXct object. Start time. By default, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT").
#' @param to a POSIXct object. End time. By default, to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT").
#' @examples 
#' ttmGetPositionSnaphots(c(100181,100182,100183), ISOdatetime(2017,01,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,01,0,00,00, tz ="GMT"))
#' 
#' @export
ttmGetPositionSnaphots <- function(accId, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT"), to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT")) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionSnapshots',accId,from,to)
  GetPositionSnapshotFrame()
}
#' Get position snapshot table
GetPositionSnapshotFrame<-function()
{
  Id = GetPositionId()
  AccountId = GetPositionAccountId()
  Symbol = GetPositionSymbol()
  SymbolAlias = GetPositionSymbolAlias()
  SymbolAliasOrName = GetPositionSymbolAliasOrName()
  Side = GetPositionSide()
  Amount = GetPositionAmount()
  AveragePrice = GetPositionAveragePrice()
  Swap = GetPositionSwap()
  Commission = GetPositionCommission()
  Modified = GetPositionModified()
  Timestamp = GetPositionTimestamp()
  ClientApp = GetPositionClientApp()
  data.table(Id, AccountId, Symbol, SymbolAlias, SymbolAliasOrName, Side, Amount, AveragePrice, Swap, Commission, Modified, Timestamp, ClientApp)
}
#' Get position snapshot field
GetPositionId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionId')
}
#' Get position snapshot field
GetPositionAccountId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionAccountId')
}
#' Get position snapshot field
GetPositionSymbol<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionSymbol')
}
#' Get position snapshot field
GetPositionSymbolAlias<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionSymbolAlias')
}
#' Get position snapshot field
GetPositionSymbolAliasOrName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionSymbolAliasOrName')
}
#' Get position snapshot field
GetPositionSide<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionSide')
}
#' Get position snapshot field
GetPositionAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionAmount')
}
#' Get position snapshot field
GetPositionAveragePrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionAveragePrice')
}
#' Get position snapshot field
GetPositionSwap<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionSwap')
}
#' Get position snapshot field
GetPositionCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionCommission')
}
#' Get position snapshot field
GetPositionModified<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionModified')
}
#' Get position snapshot field
GetPositionTimestamp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionTimestamp')
}
#' Get position snapshot field
GetPositionClientApp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetPositionClientApp')
}
