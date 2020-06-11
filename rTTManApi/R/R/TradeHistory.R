#' Gets the Trade reports as requested
#'
#' @param accId a numeric vector. Accounts ids.
#' @param from a POSIXct object. Start time. By default, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT").
#' @param to a POSIXct object. End time. By default, to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT").
#' @param skipCancelled a logical. If TRUE (default), cancelled orders are not displayed.
#' @examples 
#' ttmGetTradeReports(c(100181, 100182), ISOdatetime(1970,01,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,01,0,00,00, tz ="GMT"), TRUE)
#' 
#' @export
ttmGetTradeReports <- function(accId, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT"), to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT"), skipCancelled = TRUE) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeReports',accId, from, to, skipCancelled)
  GetTradeFrame()
}
# Get Trade report table
GetTradeFrame<-function()
{
  TradeId = GetTradeId()
  TradeDomain = GetTradeDomain()
  TradeGroup = GetTradeGroup()
  TradeOrderId = GetTradeOrderId()
  TradeOrderActionNo = GetTradeOrderActionNo()
  TradeClientOrderId = GetTradeClientOrderId()
  TradeTrType = GetTradeTrType()
  TradeTrReason = GetTradeTrReason()
  TradeTrTime = GetTradeTrTime()
  TradeSide = GetTradeSide()
  TradeOrderType = GetTradeOrderType()
  TradeParentOrderType = GetTradeParentOrderType()
  TradeOrderCreated = GetTradeOrderCreated()
  TradeOrderModified = GetTradeOrderModified()
  TradeSymbol = GetTradeSymbol()
  TradeSymbolAlias = GetTradeSymbolAlias()
  TradeSymbolAliasOrName = GetTradeSymbolAliasOrName()
  TradeSymbolFk = GetTradeSymbolFk()
  TradeOrderAmount = GetTradeOrderAmount()
  TradeOrderRemainingAmount = GetTradeOrderRemainingAmount()
  TradeOrderHiddenAmount = GetTradeOrderHiddenAmount()
  TradeOrderLastFillAmount = GetTradeOrderLastFillAmount()
  TradeOrderPrice = GetTradeOrderPrice()
  TradeOrderStopPrice = GetTradeOrderStopPrice()
  TradeOrderFillPrice = GetTradeOrderFillPrice()
  TradeReqOpenPrice = GetTradeReqOpenPrice()
  TradeReqOpenAmount = GetTradeReqOpenAmount()
  TradeReqClosePrice = GetTradeReqClosePrice()
  TradeReqCloseAmount = GetTradeReqCloseAmount()
  TradeClientApp = GetTradeClientApp()
  TradeRequestTime = GetTradeRequestTime()
  TradePosId = GetTradePosId()
  TradePosById = GetTradePosById()
  TradePosAmount = GetTradePosAmount()
  TradePosRemainingAmount = GetTradePosRemainingAmount()
  TradePosRemainingSide = GetTradePosRemainingSide()
  TradePosRemainingPrice = GetTradePosRemainingPrice()
  TradePosLastAmount = GetTradePosLastAmount()
  TradePosOpenPrice = GetTradePosOpenPrice()
  TradePosOpened = GetTradePosOpened()
  TradePosClosePrice = GetTradePosClosePrice()
  TradePosClosed = GetTradePosClosed()
  TradeCommission = GetTradeCommission()
  TradeAgentCommission = GetTradeAgentCommission()
  TradeSwap = GetTradeSwap()
  TradeProfitLoss = GetTradeProfitLoss()
  TradeBalance = GetTradeBalance()
  TradeBalanceMovement = GetTradeBalanceMovement()
  TradeBalanceCurrency = GetTradeBalanceCurrency()
  TradePlatformComment = GetTradePlatformComment()
  TradeUserComment = GetTradeUserComment()
  TradeManagerComment = GetTradeManagerComment()
  TradeUserTag = GetTradeUserTag()
  TradeManagerTag = GetTradeManagerTag()
  TradeMagic = GetTradeMagic()
  TradeMarginRateInitial = GetTradeMarginRateInitial()
  TradeStopLoss = GetTradeStopLoss()
  TradeTakeProfit = GetTradeTakeProfit()
  TradeOpenConversionRate = GetTradeOpenConversionRate()
  TradeCloseConversionRate = GetTradeCloseConversionRate()
  TradeExpired = GetTradeExpired()
  TradePosModified = GetTradePosModified()
  TradeProfitToUsdConversionRate = GetTradeProfitToUsdConversionRate()
  TradeUsdToProfitConversionRate = GetTradeUsdToProfitConversionRate()
  TradeBalanceToUsdConversionRate = GetTradeBalanceToUsdConversionRate()
  TradeUsdToBalanceConversionRate = GetTradeUsdToBalanceConversionRate()
  TradeMarginCurrencyToUsdConversionRate = GetTradeMarginCurrencyToUsdConversionRate()
  TradeUsdToMarginCurrencyConversionRate = GetTradeUsdToMarginCurrencyConversionRate()
  TradeMarginCurrency = GetTradeMarginCurrency()
  TradeProfitCurrencyToUsdConversionRate = GetTradeProfitCurrencyToUsdConversionRate()
  TradeUsdToProfitCurrencyConversionRate = GetTradeUsdToProfitCurrencyConversionRate()
  TradeProfitCurrency = GetTradeProfitCurrency()
  TradeSrcAssetToUsdConversionRate = GetTradeSrcAssetToUsdConversionRate()
  TradeUsdToSrcAssetConversionRate = GetTradeUsdToSrcAssetConversionRate()
  TradeDstAssetToUsdConversionRate = GetTradeDstAssetToUsdConversionRate()
  TradeUsdToDstAssetConversionRate = GetTradeUsdToDstAssetConversionRate()
  TradeSrcAssetCurrency = GetTradeSrcAssetCurrency()
  TradeSrcAssetAmount = GetTradeSrcAssetAmount()
  TradeSrcAssetMovement = GetTradeSrcAssetMovement()
  TradeDstAssetCurrency = GetTradeDstAssetCurrency()
  TradeDstAssetAmount = GetTradeDstAssetAmount()
  TradeDstAssetMovement = GetTradeDstAssetMovement()
  TradeOptions = GetTradeOptions()
  TradeOrderMaxVisibleAmount = GetTradeOrderMaxVisibleAmount()
  TradeReducedOpenCommissionFlag = GetTradeReducedOpenCommissionFlag()
  TradeReducedCloseCommissionFlag = GetTradeReducedCloseCommissionFlag()
  TradeAccountId = GetTradeAccountId()
  TradeSymbolPrecision = GetTradeSymbolPrecision()
  TradeProfitCurrencyToReportConversionRate = GetTradeProfitCurrencyToReportConversionRate()
  TradeMarginCurrencyToReportConversionRate = GetTradeMarginCurrencyToReportConversionRate()
  TradeDstAssetToReportConversionRate = GetTradeDstAssetToReportConversionRate()
  TradeSrcAssetToReportConversionRate = GetTradeSrcAssetToReportConversionRate()
  TradeBalanceToReportConversionRate = GetTradeBalanceToReportConversionRate()
  TradeProfitToReportConversionRate = GetTradeProfitToReportConversionRate()
  
  
  data.table(TradeAccountId,TradeId, TradeDomain, TradeGroup, TradeOrderId, TradeOrderActionNo, TradeClientOrderId, TradeTrType, 
             TradeTrReason, TradeTrTime, TradeSide, TradeOrderType, TradeParentOrderType, TradeOrderCreated, 
             TradeOrderModified, TradeSymbol, TradeSymbolAlias, TradeSymbolAliasOrName, TradeSymbolFk, TradeOrderAmount, 
             TradeOrderRemainingAmount, TradeOrderHiddenAmount, TradeOrderLastFillAmount, TradeOrderPrice, 
             TradeOrderStopPrice, TradeOrderFillPrice, TradeReqOpenPrice, TradeReqOpenAmount, TradeReqClosePrice, 
             TradeReqCloseAmount, TradeClientApp, TradeRequestTime, TradePosId, TradePosById, TradePosAmount, 
             TradePosRemainingAmount, TradePosRemainingSide, TradePosRemainingPrice, TradePosLastAmount, TradePosOpenPrice, 
             TradePosOpened, TradePosClosePrice, TradePosClosed, TradeCommission, TradeAgentCommission, TradeSwap, 
             TradeProfitLoss, TradeBalance, TradeBalanceMovement, TradeBalanceCurrency, TradePlatformComment, 
             TradeUserComment, TradeManagerComment, TradeUserTag, TradeManagerTag, TradeMagic, TradeMarginRateInitial, 
             TradeStopLoss, TradeTakeProfit, TradeOpenConversionRate, TradeCloseConversionRate, TradeExpired, 
             TradePosModified, TradeProfitToUsdConversionRate, TradeUsdToProfitConversionRate, 
             TradeBalanceToUsdConversionRate, TradeUsdToBalanceConversionRate, TradeMarginCurrencyToUsdConversionRate, 
             TradeUsdToMarginCurrencyConversionRate, TradeMarginCurrency, TradeProfitCurrencyToUsdConversionRate, 
             TradeUsdToProfitCurrencyConversionRate, TradeProfitCurrency, TradeSrcAssetToUsdConversionRate, 
             TradeUsdToSrcAssetConversionRate, TradeDstAssetToUsdConversionRate, TradeUsdToDstAssetConversionRate, 
             TradeSrcAssetCurrency, TradeSrcAssetAmount, TradeSrcAssetMovement, TradeDstAssetCurrency, TradeDstAssetAmount, 
             TradeDstAssetMovement, TradeOptions, TradeOrderMaxVisibleAmount, TradeReducedOpenCommissionFlag, 
             TradeReducedCloseCommissionFlag, TradeSymbolPrecision, TradeProfitCurrencyToReportConversionRate,TradeMarginCurrencyToReportConversionRate,
             TradeDstAssetToReportConversionRate,TradeSrcAssetToReportConversionRate,TradeBalanceToReportConversionRate,
             TradeProfitToReportConversionRate)
}
# Get Trade report field
GetTradeId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeId')
}
# Get Trade report field
GetTradeDomain<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeDomain')
}
# Get Trade report field
GetTradeGroup<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeGroup')
}
# Get Trade report field
GetTradeOrderId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderId')
}
# Get Trade report field
GetTradeOrderActionNo<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderActionNo')
}
# Get Trade report field
GetTradeClientOrderId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeClientOrderId')
}
# Get Trade report field
GetTradeTrType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeTrType')
}
# Get Trade report field
GetTradeTrReason<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeTrReason')
}
# Get Trade report field
GetTradeTrTime<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeTrTime')
}
# Get Trade report field
GetTradeSide<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSide')
}
# Get Trade report field
GetTradeOrderType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderType')
}
# Get Trade report field
GetTradeParentOrderType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeParentOrderType')
}
# Get Trade report field
GetTradeOrderCreated<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderCreated')
}
# Get Trade report field
GetTradeOrderModified<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderModified')
}
# Get Trade report field
GetTradeSymbol<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSymbol')
}
# Get Trade report field
GetTradeSymbolAlias<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSymbolAlias')
}
# Get Trade report field
GetTradeSymbolAliasOrName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSymbolAliasOrName')
}
# Get Trade report field
GetTradeSymbolFk<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSymbolFk')
}
# Get Trade report field
GetTradeOrderAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderAmount')
}
# Get Trade report field
GetTradeOrderRemainingAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderRemainingAmount')
}
# Get Trade report field
GetTradeOrderHiddenAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderHiddenAmount')
}
# Get Trade report field
GetTradeOrderLastFillAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderLastFillAmount')
}
# Get Trade report field
GetTradeOrderPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderPrice')
}
# Get Trade report field
GetTradeOrderStopPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderStopPrice')
}
# Get Trade report field
GetTradeOrderFillPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderFillPrice')
}
# Get Trade report field
GetTradeReqOpenPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeReqOpenPrice')
}
# Get Trade report field
GetTradeReqOpenAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeReqOpenAmount')
}
# Get Trade report field
GetTradeReqClosePrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeReqClosePrice')
}
# Get Trade report field
GetTradeReqCloseAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeReqCloseAmount')
}
# Get Trade report field
GetTradeClientApp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeClientApp')
}
# Get Trade report field
GetTradeRequestTime<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeRequestTime')
}
# Get Trade report field
GetTradePosId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosId')
}
# Get Trade report field
GetTradePosById<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosById')
}
# Get Trade report field
GetTradePosAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosAmount')
}
# Get Trade report field
GetTradePosRemainingAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosRemainingAmount')
}
# Get Trade report field
GetTradePosRemainingSide<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosRemainingSide')
}
# Get Trade report field
GetTradePosRemainingPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosRemainingPrice')
}
# Get Trade report field
GetTradePosLastAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosLastAmount')
}
# Get Trade report field
GetTradePosOpenPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosOpenPrice')
}
# Get Trade report field
GetTradePosOpened<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosOpened')
}
# Get Trade report field
GetTradePosClosePrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosClosePrice')
}
# Get Trade report field
GetTradePosClosed<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosClosed')
}
# Get Trade report field
GetTradeCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeCommission')
}
# Get Trade report field
GetTradeAgentCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeAgentCommission')
}
# Get Trade report field
GetTradeSwap<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSwap')
}
# Get Trade report field
GetTradeProfitLoss<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeProfitLoss')
}
# Get Trade report field
GetTradeBalance<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeBalance')
}
# Get Trade report field
GetTradeBalanceMovement<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeBalanceMovement')
}
# Get Trade report field
GetTradeBalanceCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeBalanceCurrency')
}
# Get Trade report field
GetTradePlatformComment<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePlatformComment')
}
# Get Trade report field
GetTradeUserComment<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUserComment')
}
# Get Trade report field
GetTradeManagerComment<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeManagerComment')
}
# Get Trade report field
GetTradeUserTag<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUserTag')
}
# Get Trade report field
GetTradeManagerTag<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeManagerTag')
}
# Get Trade report field
GetTradeMagic<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeMagic')
}
# Get Trade report field
GetTradeMarginRateInitial<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeMarginRateInitial')
}
# Get Trade report field
GetTradeStopLoss<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeStopLoss')
}
# Get Trade report field
GetTradeTakeProfit<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeTakeProfit')
}
# Get Trade report field
GetTradeOpenConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOpenConversionRate')
}
# Get Trade report field
GetTradeCloseConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeCloseConversionRate')
}
# Get Trade report field
GetTradeExpired<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeExpired')
}
# Get Trade report field
GetTradePosModified<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradePosModified')
}
# Get Trade report field
GetTradeProfitToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeProfitToUsdConversionRate')
}
# Get Trade report field
GetTradeUsdToProfitConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUsdToProfitConversionRate')
}
# Get Trade report field
GetTradeBalanceToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeBalanceToUsdConversionRate')
}
# Get Trade report field
GetTradeUsdToBalanceConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUsdToBalanceConversionRate')
}
# Get Trade report field
GetTradeMarginCurrencyToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeMarginCurrencyToUsdConversionRate')
}
# Get Trade report field
GetTradeUsdToMarginCurrencyConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUsdToMarginCurrencyConversionRate')
}
# Get Trade report field
GetTradeMarginCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeMarginCurrency')
}
# Get Trade report field
GetTradeProfitCurrencyToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeProfitCurrencyToUsdConversionRate')
}
# Get Trade report field
GetTradeUsdToProfitCurrencyConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUsdToProfitCurrencyConversionRate')
}
# Get Trade report field
GetTradeProfitCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeProfitCurrency')
}
# Get Trade report field
GetTradeSrcAssetToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSrcAssetToUsdConversionRate')
}
# Get Trade report field
GetTradeUsdToSrcAssetConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUsdToSrcAssetConversionRate')
}
# Get Trade report field
GetTradeDstAssetToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeDstAssetToUsdConversionRate')
}
# Get Trade report field
GetTradeUsdToDstAssetConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeUsdToDstAssetConversionRate')
}
# Get Trade report field
GetTradeSrcAssetCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSrcAssetCurrency')
}
# Get Trade report field
GetTradeSrcAssetAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSrcAssetAmount')
}
# Get Trade report field
GetTradeSrcAssetMovement<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSrcAssetMovement')
}
# Get Trade report field
GetTradeDstAssetCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeDstAssetCurrency')
}
# Get Trade report field
GetTradeDstAssetAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeDstAssetAmount')
}
# Get Trade report field
GetTradeDstAssetMovement<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeDstAssetMovement')
}
# Get Trade report field
GetTradeOptions<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOptions')
}
# Get Trade report field
GetTradeOrderMaxVisibleAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeOrderMaxVisibleAmount')
}
# Get Trade report field
GetTradeReducedOpenCommissionFlag<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeReducedOpenCommissionFlag')
}
# Get Trade report field
GetTradeReducedCloseCommissionFlag<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeReducedCloseCommissionFlag')
}
# Get Trade report field
GetTradeSymbolPrecision<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSymbolPrecision')
}
# Get Trade report field
GetTradeAccountId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeAccountId')
}

# Get Trade report field
GetTradeProfitCurrencyToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeProfitCurrencyToReportConversionRate')
}

# Get Trade report field
GetTradeMarginCurrencyToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeMarginCurrencyToReportConversionRate')
}

# Get Trade report field
GetTradeDstAssetToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeDstAssetToReportConversionRate')
}

# Get Trade report field
GetTradeSrcAssetToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeSrcAssetToReportConversionRate')
}

# Get Trade report field
GetTradeBalanceToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeBalanceToReportConversionRate')
}

# Get Trade report field
GetTradeProfitToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTradeProfitToReportConversionRate')
}