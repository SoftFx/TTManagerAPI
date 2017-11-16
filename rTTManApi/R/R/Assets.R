#' Gets the Assets as requested
#'
#' @param accountId a numeric. Account id
#' @examples 
#' ttmGetAssets(100181)
#' @export
ttmGetAssets <- function(accountId) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAssets',accountId)
  GetAssetFrame()
}
#' Get Asset table
GetAssetFrame<-function()
{
  Currency = GetAssetCurrency()
  CurrencyId = GetAssetCurrencyId()
  Amount = GetAssetAmount()
  FreeAmount = GetAssetFreeAmount()
  LockedAmount = GetAssetLockedAmount()
  data.table( Currency,CurrencyId,Amount,FreeAmount,LockedAmount)
}
#' Get Asset field
GetAssetCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAssetCurrency')
}
#' Get Asset field
GetAssetCurrencyId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAssetCurrencyId')
}
#' Get Asset field
GetAssetAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAssetAmount')
}
#' Get Asset field
GetAssetFreeAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAssetFreeAmount')
}
#' Get Asset field
GetAssetLockedAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAssetLockedAmount')
}
