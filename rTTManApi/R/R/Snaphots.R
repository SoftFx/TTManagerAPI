#' Gets the Snapshots as requested
#'
#' @param accId a numeric vector. Accounts ids.
#' @param from a POSIXct object. Start time. By default, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT").
#' @param to a POSIXct object. End time. By default, to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT").
#' @examples 
#' ttmGetAssetSnapshots(c(100181,100182,100183), ISOdatetime(2017,01,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,01,0,00,00, tz ="GMT"))
#' 
#' @export
ttmGetAssetSnapshots <- function(accId, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT"), to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT")) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAssetSnapshots',accId,from,to)
  GetSnapshotFrame()
}
#' Get Snapshot table
GetSnapshotFrame<-function()
{
  Currency = GetSnapshotCurrency()
  Amount = GetSnapshotAmount()
  FreeAmount = GetSnapshotFreeAmount()
  LockedAmount = GetSnapshotLockedAmount()
  CurrencyToUsdConversionRate = GetSnapshotCurrencyToUsdConversionRate()
  UsdToCurrencyConversionRate = GetSnapshotUsdToCurrencyConversionRate()
  Timestamp = GetSnapshotTimestamp()
  AccountId = GetSnapshotAccountId()
  data.table(AccountId,Currency,Amount,FreeAmount,LockedAmount,CurrencyToUsdConversionRate,UsdToCurrencyConversionRate,Timestamp)
}
#' Get Snapshot field
GetSnapshotCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotCurrency')
}
#' Get Snapshot field
GetSnapshotAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotAmount')
}
#' Get Snapshot field
GetSnapshotFreeAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotFreeAmount')
}
#' Get Snapshot field
GetSnapshotLockedAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotLockedAmount')
}
#' Get Snapshot field
GetSnapshotCurrencyToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotCurrencyToUsdConversionRate')
}
#' Get Snapshot field
GetSnapshotUsdToCurrencyConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotUsdToCurrencyConversionRate')
}
#' Get Snapshot field
GetSnapshotTimestamp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotTimestamp')
}
#' Get Snapshot field
GetSnapshotAccountId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSnapshotAccountId')
}