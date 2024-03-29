#' Create new Symbol
#'
#' @param symbol a character. Symbol
#' @param security a character. Security
#' @param isin a character. ISIN
#' @param alias a character. Alias
#' @param marginCurrency a character. MarginCurrency
#' @param profitCurrency a character. ProfitCurrency
#' @param precision a numeric. Precision
#' @param contractSize a numeric. ContractSize
#' @param marginFactorFractional a numeric. MarginFactorFractional
#' @param swapEnabled a boolean. SwapEnabled
#' @param marginMode a character. MarginMode
#' @param profitMode a character. ProfitMode
#' @param marginHedged a numeric.  MarginHedged
#' @param swapType a character. SwapType. For TTS only "Points" or "PercentPerYear"
#' @param swapSizeLong a numeric. SwapSizeLong
#' @param swapSizeShort a numeric SwapSizeShort
#' @param description a character. SwapSizeShort
#' 
#' @export
ttmCreateNewSymbol <- function(symbol, security, isin, alias, marginCurrency, profitCurrency,
                               precision, contractSize, marginFactorFractional = 1, swapEnabled = TRUE, marginMode = "CFD", profitMode = "CFD",
                               marginHedged = 0.5, swapType = "PercentPerYear", swapSizeLong = 0, swapSizeShort = 0, description = ""
                               ){
  tempMarginMode <- -1
  tempProfitMode <- -1
  tempSwapType <- -1
  if(is.element(marginMode, names(MarginCalculationModes))){
    tempMarginMode <- MarginCalculationModes[[marginMode]]
  }else{
    stop(paste("Wrong Margin Mode -", marginMode))
  }
  if(is.element(profitMode, names(ProfitCalculationModes))){
    tempProfitMode <- ProfitCalculationModes[[profitMode]]
  }else{
    stop(paste("Wrong Profit Mode -", marginMode))
  }
  if(is.element(swapType, names(SwapType))){
    tempSwapType <- SwapType[[swapType]]
  }else{
    stop(paste("Wrong SwapType -", swapType))
  }
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'CreateSymbol', symbol ,security, isin, alias, marginCurrency, profitCurrency,
                                precision, contractSize, marginFactorFractional, swapEnabled, tempMarginMode, tempProfitMode,
                                marginHedged, tempSwapType, swapSizeLong, swapSizeShort, description)
}

#' Modify Symbol
#' 
#' @param symbol a character. Symbol
#' @param isin a character. New ISIN value
#' 
#' @export
ttmModifySymbol <- function(symbol, isin) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'ModifySymbol', symbol, isin)
}

#' Modify Symbol ExtendedName and Description
#' 
#' @param symbolId a character. Symbol
#' @param newExtendedName a character. New Extended Name value
#' @param newDescription a character. New Description value
#' @export
ttmModifySymbolExtendedNameDescription <- function(symbol, newExtendedName, newDescription) {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'ModifySymbolExtendedNameDescription', symbol, newExtendedName, newDescription)
}


#' Gets the symbols as requested
#' @examples 
#' ttmGetAllSymbols()
#'
#' @export
ttmGetAllSymbols <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolsInfo')
  GetSymbolFrame()
}

#' Change symbol swap
#'
#' @param symbol a character. Symbol
#' @param swapSizeShort a double. SwapSizeShort
#' @param swapSizeLong a double. SwapSizeLong
#' @param swapType a character. SwapType. For TTS only "Points" or "PercentPerYear"
#' @examples 
#' ttmModifySymbolSwap("BTCBYN", 10, 10, "Points")
#' 
#' @export
ttmModifySymbolSwap <- function(symbol = "",swapSizeShort = "",swapSizeLong = "",swapType = "") {
  hResult = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'ModifySymbolSwap', symbol, swapSizeShort,swapSizeLong)
}


# Get Symbol table
GetSymbolFrame<-function()
{
  Id = GetSymbolId()
  Symbol = GetSymbolSymbol()
  Security = GetSymbolSecurity()
  Precision = GetSymbolPrecision()
  TradeIsAllowed = GetSymbolTradeIsAllowed()
  MarginMode = GetSymbolMarginMode()
  ProfitMode = GetSymbolProfitMode()
  QuotesWriteMode = GetSymbolQuotesWriteMode()
  ContractSizeFractional = GetSymbolContractSizeFractional()
  MarginHedged = GetSymbolMarginHedged()
  MarginFactorFractional = GetSymbolMarginFactorFractional()
  MarginStrongMode = GetSymbolMarginStrongMode()
  MarginCurrency = GetSymbolMarginCurrency()
  MarginCurrencyId = GetSymbolMarginCurrencyId()
  MarginCurrencyPrecision = GetSymbolMarginCurrencyPrecision()
  MarginCurrencySortOrder = GetSymbolMarginCurrencySortOrder()
  ProfitCurrency = GetSymbolProfitCurrency()
  ProfitCurrencyId = GetSymbolProfitCurrencyId()
  ProfitCurrencyPrecision = GetSymbolProfitCurrencyPrecision()
  ProfitCurrencySortOrder = GetSymbolProfitCurrencySortOrder()
  ColorRef = GetSymbolColorRef()
  Description = GetSymbolDescription()
  SwapEnabled = GetSymbolSwapEnabled()
  SwapSizeShort = GetSymbolSwapSizeShort()
  SwapSizeLong = GetSymbolSwapSizeLong()
  IsPrimary = GetSymbolIsPrimary()
  SortOrder = GetSymbolSortOrder()
  IsQuotesFilteringDisabled = GetSymbolIsQuotesFilteringDisabled()
  Schedule = GetSymbolSchedule()
  DefaultSlippage = GetSymbolDefaultSlippage()
  StopOrderMarginReduction = GetSymbolStopOrderMarginReduction()
  HiddenLimitOrderMarginReduction = GetSymbolHiddenLimitOrderMarginReduction()
  SwapType = GetSymbolSwapType()
  TripleSwapDay = GetSymbolTripleSwapDay()
  ISIN = GetSymbolISIN()
  Alias = GetSymbolAlias()
  SymbolName = GetSymbolName()
  ExtendedName = GetSymbolExtendedName()
  data.table(Id,Symbol,Security,Precision,TradeIsAllowed,MarginMode,ProfitMode,QuotesWriteMode,ContractSizeFractional,MarginHedged,
             MarginFactorFractional,MarginStrongMode,MarginCurrency,MarginCurrencyId,MarginCurrencyPrecision,MarginCurrencySortOrder,
             ProfitCurrency,ProfitCurrencyId,ProfitCurrencyPrecision,ProfitCurrencySortOrder,ColorRef,Description,SwapEnabled,SwapSizeShort,
             SwapSizeLong,IsPrimary,SortOrder,IsQuotesFilteringDisabled,Schedule,DefaultSlippage,StopOrderMarginReduction,HiddenLimitOrderMarginReduction,
             SwapType,TripleSwapDay,ISIN,Alias,SymbolName, ExtendedName)
}
# Get Symbol field
GetSymbolId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolId')
}
# Get Symbol field
GetSymbolSymbol<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSymbol')
}
# Get Symbol field
GetSymbolSecurity<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSecurity')
}
# Get Symbol field
GetSymbolPrecision<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolPrecision')
}
# Get Symbol field
GetSymbolTradeIsAllowed<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolTradeIsAllowed')
}
# Get Symbol field
GetSymbolMarginMode<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginMode')
}
# Get Symbol field
GetSymbolProfitMode<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolProfitMode')
}
# Get Symbol field
GetSymbolQuotesWriteMode<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolQuotesWriteMode')
}
# Get Symbol field
GetSymbolContractSizeFractional<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolContractSizeFractional')
}
# Get Symbol field
GetSymbolMarginHedged<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginHedged')
}
# Get Symbol field
GetSymbolMarginFactorFractional<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginFactorFractional')
}
# Get Symbol field
GetSymbolMarginStrongMode<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginStrongMode')
}
# Get Symbol field
GetSymbolMarginCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginCurrency')
}
# Get Symbol field
GetSymbolMarginCurrencyId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginCurrencyId')
}
# Get Symbol field
GetSymbolMarginCurrencyPrecision<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginCurrencyPrecision')
}
# Get Symbol field
GetSymbolMarginCurrencySortOrder<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolMarginCurrencySortOrder')
}
# Get Symbol field
GetSymbolProfitCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolProfitCurrency')
}
# Get Symbol field
GetSymbolProfitCurrencyId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolProfitCurrencyId')
}
# Get Symbol field
GetSymbolProfitCurrencyPrecision<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolProfitCurrencyPrecision')
}
# Get Symbol field
GetSymbolProfitCurrencySortOrder<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolProfitCurrencySortOrder')
}
# Get Symbol field
GetSymbolColorRef<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolColorRef')
}
# Get Symbol field
GetSymbolDescription<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolDescription')
}
# Get Symbol field
GetSymbolSwapEnabled<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSwapEnabled')
}
# Get Symbol field
GetSymbolSwapSizeShort<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSwapSizeShort')
}
# Get Symbol field
GetSymbolSwapSizeLong<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSwapSizeLong')
}
# Get Symbol field
GetSymbolIsPrimary<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolIsPrimary')
}
# Get Symbol field
GetSymbolSortOrder<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSortOrder')
}
# Get Symbol field
GetSymbolIsQuotesFilteringDisabled<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolIsQuotesFilteringDisabled')
}
# Get Symbol field
GetSymbolSchedule<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSchedule')
}
# Get Symbol field
GetSymbolDefaultSlippage<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolDefaultSlippage')
}
# Get Symbol field
GetSymbolStopOrderMarginReduction<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolStopOrderMarginReduction')
}
# Get Symbol field
GetSymbolHiddenLimitOrderMarginReduction<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolHiddenLimitOrderMarginReduction')
}
# Get Symbol field
GetSymbolSwapType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolSwapType')
}
# Get Symbol field
GetSymbolTripleSwapDay<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolTripleSwapDay')
}
# Get Symbol field
GetSymbolISIN <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolISIN')
}
# Get Symbol field
GetSymbolAlias <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolAlias')
}
GetSymbolName <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolName')
}
GetSymbolExtendedName <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSymbolExtendedName')
}
MarginCalculationModes <- list("Forex" = 0,
                               "CFD" = 1,
                               "Futures" = 2,
                               "CFD_Index" = 3,
                               "CFD_Leverage" = 4
                      )
ProfitCalculationModes <- list("Forex" = 0,
                               "CFD" = 1,
                               "Futures" = 2,
                               "CFD_Index" = 3,
                               "CFD_Leverage" = 4
                               )

SwapType <- list("Points" = 0,
                 "PercentPerYear" = 1
                 )


