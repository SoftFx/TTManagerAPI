#' Gets the Orders as requested
#' @examples 
#' ttmGetAllOrders()
#'
#' @export
ttmGetAllOrders <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllOrders')
  GetOrderFrame()
}

#' Gets the Orders as requested with login
#' 
#' @param accountId a numeric. Account id
#' @examples 
#' ttmGetOrders(100185)
#' 
#' @export
ttmGetOrders <- function(accountId) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrders',accountId)
  GetOrderFrame()
}



#' Gets the orders snaphots as requested
#' 
#' @param accId a numeric vector. Accounts ids.
#' @param from a POSIXct object. Start time. By default, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT").
#' @param to a POSIXct object. End time. By default, to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT").
#' @examples 
#' ttmGetPositionSnaphots(c(100181,100182,100183), ISOdatetime(2017,01,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,01,0,00,00, tz ="GMT"))
#' 
#' @export
ttmGetOrderSnapshots <- function(accId, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT"), to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT")) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderSnapshots', accId, from, to)
  GetOrderFrame()
}

# Get Order table
GetOrderFrame<-function()
{
  RangeId = GetOrderRangeId()
  AccountId = GetOrderAccountId()
  Symbol = GetOrderSymbol()
  SymbolAlias = GetOrderSymbolAlias()
  SymbolAliasOrName = GetOrderSymbolAliasOrName()
  OrderId = GetOrderOrderId()
  ClientOrderId = GetOrderClientOrderId()
  ParentOrderId = GetOrderParentOrderId()
  Price = GetOrderPrice()
  Side = GetOrderSide()
  Type = GetOrderType()
  InitialType = GetOrderInitialType()
  Status = GetOrderStatus()
  Amount = GetOrderAmount()
  RemainingAmount = GetOrderRemainingAmount()
  AggrFillPrice = GetOrderAggrFillPrice()
  AverageFillPrice = GetOrderAverageFillPrice()
  Created = GetOrderCreated()
  Modified = GetOrderModified()
  Filled = GetOrderFilled()
  PositionCreated = GetOrderPositionCreated()
  StopLoss = GetOrderStopLoss()
  TakeProfit = GetOrderTakeProfit()
  Profit = GetOrderProfit()
  Margin = GetOrderMargin()
  UserComment = GetOrderUserComment()
  ManagerComment = GetOrderManagerComment()
  UserTag = GetOrderUserTag()
  ManagerTag = GetOrderManagerTag()
  Magic = GetOrderMagic()
  Commission = GetOrderCommission()
  AgentCommision = GetOrderAgentCommision()
  Swap = GetOrderSwap()
  Expired = GetOrderExpired()
  ClosePrice = GetOrderClosePrice()
  MarginRateInitial = GetOrderMarginRateInitial()
  MarginRateCurrent = GetOrderMarginRateCurrent()
  OpenConversionRate = GetOrderOpenConversionRate()
  CloseConversionRate = GetOrderCloseConversionRate()
  Version = GetOrderVersion()
  Options = GetOrderOptions()
  Taxes = GetOrderTaxes()
  ReqOpenPrice = GetOrderReqOpenPrice()
  ReqOpenAmount = GetOrderReqOpenAmount()
  ClientApp = GetOrderClientApp()
  IsReducedOpenCommission = GetOrderIsReducedOpenCommission()
  IsReducedCloseCommission = GetOrderIsReducedCloseCommission()
  MaxVisibleAmount = GetOrderMaxVisibleAmount()
  FilledAmount = GetOrderFilledAmount()
  VisibleAmount = GetOrderVisibleAmount()
  TotalCommission = GetOrderTotalCommission()
  Activation = GetOrderActivation()
  IsPending = GetOrderIsPending()
  data.table(RangeId, AccountId, Symbol, SymbolAlias, SymbolAliasOrName, OrderId, ClientOrderId, ParentOrderId, 
             Price, Side, Type, InitialType, Status, Amount, RemainingAmount, AggrFillPrice, AverageFillPrice, 
             Created, Modified, Filled, PositionCreated, StopLoss, TakeProfit, Profit, Margin, UserComment, 
             ManagerComment, UserTag, ManagerTag, Magic, Commission, AgentCommision, Swap, Expired, ClosePrice, 
             MarginRateInitial, MarginRateCurrent, OpenConversionRate, CloseConversionRate, Version, Options, 
             Taxes, ReqOpenPrice, ReqOpenAmount, ClientApp, IsReducedOpenCommission, IsReducedCloseCommission, 
             MaxVisibleAmount, FilledAmount, VisibleAmount, TotalCommission, Activation, IsPending)
}
# Get Order field
GetOrderRangeId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderRangeId')
}
# Get Order field
GetOrderAccountId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderAccountId')
}
# Get Order field
GetOrderSymbol<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderSymbol')
}
# Get Order field
GetOrderSymbolAlias<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderSymbolAlias')
}
# Get Order field
GetOrderSymbolAliasOrName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderSymbolAliasOrName')
}
# Get Order field
GetOrderOrderId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderOrderId')
}
# Get Order field
GetOrderClientOrderId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderClientOrderId')
}
# Get Order field
GetOrderParentOrderId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderParentOrderId')
}
# Get Order field
GetOrderPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderPrice')
}
# Get Order field
GetOrderSide<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderSide')
}
# Get Order field
GetOrderType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderType')
}
# Get Order field
GetOrderInitialType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderInitialType')
}
# Get Order field
GetOrderStatus<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderStatus')
}
# Get Order field
GetOrderAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderAmount')
}
# Get Order field
GetOrderRemainingAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderRemainingAmount')
}
# Get Order field
GetOrderAggrFillPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderAggrFillPrice')
}
# Get Order field
GetOrderAverageFillPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderAverageFillPrice')
}
# Get Order field
GetOrderCreated<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderCreated')
}
# Get Order field
GetOrderModified<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderModified')
}
# Get Order field
GetOrderFilled<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderFilled')
}
# Get Order field
GetOrderPositionCreated<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderPositionCreated')
}
# Get Order field
GetOrderStopLoss<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderStopLoss')
}
# Get Order field
GetOrderTakeProfit<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderTakeProfit')
}
# Get Order field
GetOrderProfit<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderProfit')
}
# Get Order field
GetOrderMargin<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderMargin')
}
# Get Order field
GetOrderUserComment<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderUserComment')
}
# Get Order field
GetOrderManagerComment<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderManagerComment')
}
# Get Order field
GetOrderUserTag<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderUserTag')
}
# Get Order field
GetOrderManagerTag<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderManagerTag')
}
# Get Order field
GetOrderMagic<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderMagic')
}
# Get Order field
GetOrderCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderCommission')
}
# Get Order field
GetOrderAgentCommision<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderAgentCommision')
}
# Get Order field
GetOrderSwap<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderSwap')
}
# Get Order field
GetOrderExpired<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderExpired')
}
# Get Order field
GetOrderClosePrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderClosePrice')
}
# Get Order field
GetOrderMarginRateInitial<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderMarginRateInitial')
}
# Get Order field
GetOrderMarginRateCurrent<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderMarginRateCurrent')
}
# Get Order field
GetOrderOpenConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderOpenConversionRate')
}
# Get Order field
GetOrderCloseConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderCloseConversionRate')
}
# Get Order field
GetOrderVersion<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderVersion')
}
# Get Order field
GetOrderOptions<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderOptions')
}
# Get Order field
GetOrderTaxes<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderTaxes')
}
# Get Order field
GetOrderReqOpenPrice<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderReqOpenPrice')
}
# Get Order field
GetOrderReqOpenAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderReqOpenAmount')
}
# Get Order field
GetOrderClientApp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderClientApp')
}
# Get Order field
GetOrderIsReducedOpenCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderIsReducedOpenCommission')
}
# Get Order field
GetOrderIsReducedCloseCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderIsReducedCloseCommission')
}
# Get Order field
GetOrderMaxVisibleAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderMaxVisibleAmount')
}
# Get Order field
GetOrderFilledAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderFilledAmount')
}
# Get Order field
GetOrderVisibleAmount<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderVisibleAmount')
}
# Get Order field
GetOrderTotalCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderTotalCommission')
}
# Get Order field
GetOrderActivation<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderActivation')
}
# Get Order field
GetOrderIsPending<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOrderIsPending')
}

#' Create the Orders as requested
#' @examples 
#' ttmCreateNewOrder()
#'
#' @export
ttmCreateNewOrder <- function(login, orderType, orderSide, symbol, amount,stopPrice, price, stopLoss, takeProfit,UserComment, ManagerComment, Expiration, reqType = 0) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'CreateNewOrder', login, orderType, orderSide, symbol, amount,stopPrice, price, stopLoss, takeProfit,UserComment, ManagerComment, Expiration, reqType)
}