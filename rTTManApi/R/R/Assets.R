#' Gets All Assets as requested
#'
#' @examples 
#' ttmGetAllAssets()
#' @export
ttmGetAllAssets <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssets')
  GetAllAssetFrame()
}
#' Get All Asset Table
GetAllAssetFrame <- function(){
  AccountId = GetAllAssetAccount()
  Currency = GetAllAssetCurrency()
  CurrencyId = GetAllAssetCurrencyId()
  Amount = GetAllAssetAmount()
  FreeAmount = GetAllAssetFreeAmount()
  LockedAmount = GetAllAssetLockedAmount()
  ConversionToUsd = GetAllAssetConversionToUsd()
  data.table(AccountId, Currency,CurrencyId,Amount,FreeAmount,LockedAmount, ConversionToUsd)
}
#' Get All Asset field
GetAllAssetCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssetCurrency')
}
#' Get All Asset field
GetAllAssetCurrencyId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssetCurrencyId')
}
#' Get All Asset field
GetAllAssetAccount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssetAccount')
}
#' Get All Asset field
GetAllAssetAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssetAmount')
}
#' Get All Asset field
GetAllAssetFreeAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssetFreeAmount')
}
#' Get All Asset field
GetAllAssetLockedAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssetLockedAmount')
}

#'Get All Asset field
GetAllAssetConversionToUsd <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAssetConversionToUsd')
}



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
