#' Gets All Currencies
#'
#' @examples 
#' ttmGetAllCurrencies()
#' @export
ttmGetAllCurrencies <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrencies')
  GetAllCurrencyFrame()
}
# Get All Currency Table
GetAllCurrencyFrame <- function(){
  Id = GetAllCurrenciesId()
  Currency = GetAllCurrenciesName()
  Description = GetAllCurrenciesDescription()
  Digits = GetAllCurrenciesDigits()
  Type = GetAllCurrenciesType()
  Tax = GetAllCurrenciesTax()
  DefaultStockFee = GetAllCurrenciesDefaultStockFee()
  data.table(Id, Currency, Description, Digits, Type, Tax, DefaultStockFee)
}
# Get All Currency field
GetAllCurrenciesId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrenciesId')
}
# Get All Currency field
GetAllCurrenciesName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrenciesName')
}
# Get All Currency field
GetAllCurrenciesDescription<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrenciesDescription')
}
# Get All Currency field
GetAllCurrenciesDigits<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrenciesDigits')
}
# Get All Currency field
GetAllCurrenciesType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrenciesType')
}
# Get All Currency field
GetAllCurrenciesTax<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrenciesTax')
}
# Get All Currency field
GetAllCurrenciesDefaultStockFee <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCurrenciesDefaultStockFee')
}
