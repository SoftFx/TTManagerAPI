#' Gets the Account snaphots as requested
#' 
#' @param accId a numeric vector. Accounts ids.
#' @param from a POSIXct object. Start time. By default, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT").
#' @param to a POSIXct object. End time. By default, to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT").
#' @examples 
#' ttmGetAccountSnaphots(c(100181,100182,100183), ISOdatetime(1970,01,01,0,00,00, tz ="GMT"), ISOdatetime(2017,08,01,0,00,00, tz ="GMT"))
#' 
#' @export
ttmGetAccountSnaphots <- function(accId, from = ISOdatetime(1970,01,01,0,00,00, tz ="GMT"), to = ISOdatetime(2017,08,01,0,00,00, tz ="GMT")) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshots',accId,from,to)
  GetAccountSnapshotFrame()
}
#' Get Account snapshot table
GetAccountSnapshotFrame<-function()
{
  Id = GetAccountSnapshotId()
  AccountId = GetAccountSnapshotAccountId()
  Timestamp = GetAccountSnapshotTimestamp()
  Server = GetAccountSnapshotServer()
  Domain = GetAccountSnapshotDomain()
  Group = GetAccountSnapshotGroup()
  AccountingType = GetAccountSnapshotAccountingType()
  Leverage = GetAccountSnapshotLeverage()
  Balance = GetAccountSnapshotBalance()
  BalanceCurrency = GetAccountSnapshotBalanceCurrency()
  Profit = GetAccountSnapshotProfit()
  Commission = GetAccountSnapshotCommission()
  AgentCommission = GetAccountSnapshotAgentCommission()
  TotalCommission = GetAccountSnapshotTotalCommission()
  Swap = GetAccountSnapshotSwap()
  TotalProfitLoss = GetAccountSnapshotTotalProfitLoss()
  Equity = GetAccountSnapshotEquity()
  Margin = GetAccountSnapshotMargin()
  MarginLevel = GetAccountSnapshotMarginLevel()
  IsBlocked = GetAccountSnapshotIsBlocked()
  IsReadonly = GetAccountSnapshotIsReadonly()
  IsValid = GetAccountSnapshotIsValid()
  BalanceToUsdConversionRate = GetAccountSnapshotBalanceToUsdConversionRate()
  UsdToBalanceConversionRate = GetAccountSnapshotUsdToBalanceConversionRate()
  ProfitToUsdConversionRate = GetAccountSnapshotProfitToUsdConversionRate()
  UsdToProfitConversionRate = GetAccountSnapshotUsdToProfitConversionRate()

  BalanceToReportConversionRate = GetAccountSnapshotBalanceToReportConversionRate()
  ReportToBalanceConversionRate = GetAccountSnapshotReportToBalanceConversionRate()
  ReportToProfitConversionRate = GetAccountSnapshotReportToProfitConversionRate()
  ProfitToReportConversionRate = GetAccountSnapshotProfitToReportConversionRate()
  ReportCurrency = GetAccountSnapshotReportCurrency()
  
  data.table(Id, AccountId, Timestamp, Server, Domain, Group, AccountingType, Leverage, Balance, BalanceCurrency, Profit, Commission, AgentCommission,
             TotalCommission, Swap, TotalProfitLoss, Equity, Margin, MarginLevel, IsBlocked, IsReadonly, IsValid, BalanceToUsdConversionRate,
             UsdToBalanceConversionRate, ProfitToUsdConversionRate, UsdToProfitConversionRate, 
             BalanceToReportConversionRate, ReportToBalanceConversionRate, ReportToProfitConversionRate , ProfitToReportConversionRate, ReportCurrency)
}
#' Get Account snapshot field
GetAccountSnapshotId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotId')
}
#' Get Account snapshot field
GetAccountSnapshotAccountId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotAccountId')
}
#' Get Account snapshot field
GetAccountSnapshotTimestamp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotTimestamp')
}
#' Get Account snapshot field
GetAccountSnapshotServer<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotServer')
}
#' Get Account snapshot field
GetAccountSnapshotDomain<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotDomain')
}
#' Get Account snapshot field
GetAccountSnapshotGroup<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotGroup')
}
#' Get Account snapshot field
GetAccountSnapshotAccountingType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotAccountingType')
}
#' Get Account snapshot field
GetAccountSnapshotLeverage<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotLeverage')
}
#' Get Account snapshot field
GetAccountSnapshotBalance<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotBalance')
}
#' Get Account snapshot field
GetAccountSnapshotBalanceCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotBalanceCurrency')
}
#' Get Account snapshot field
GetAccountSnapshotProfit<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotProfit')
}
#' Get Account snapshot field
GetAccountSnapshotCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotCommission')
}
#' Get Account snapshot field
GetAccountSnapshotAgentCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotAgentCommission')
}
#' Get Account snapshot field
GetAccountSnapshotTotalCommission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotTotalCommission')
}
#' Get Account snapshot field
GetAccountSnapshotSwap<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotSwap')
}
#' Get Account snapshot field
GetAccountSnapshotTotalProfitLoss<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotTotalProfitLoss')
}
#' Get Account snapshot field
GetAccountSnapshotEquity<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotEquity')
}
#' Get Account snapshot field
GetAccountSnapshotMargin<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotMargin')
}
#' Get Account snapshot field
GetAccountSnapshotMarginLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotMarginLevel')
}
#' Get Account snapshot field
GetAccountSnapshotIsBlocked<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotIsBlocked')
}
#' Get Account snapshot field
GetAccountSnapshotIsReadonly<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotIsReadonly')
}
#' Get Account snapshot field
GetAccountSnapshotIsValid<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotIsValid')
}
#' Get Account snapshot field
GetAccountSnapshotBalanceToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotBalanceToUsdConversionRate')
}
#' Get Account snapshot field
GetAccountSnapshotUsdToBalanceConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotUsdToBalanceConversionRate')
}
#' Get Account snapshot field
GetAccountSnapshotProfitToUsdConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotProfitToUsdConversionRate')
}
#' Get Account snapshot field
GetAccountSnapshotUsdToProfitConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotUsdToProfitConversionRate')
}
#' Get Account snapshot field
GetAccountSnapshotBalanceToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotBalanceToReportConversionRate')
}
#' Get Account snapshot field
GetAccountSnapshotReportToBalanceConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotReportToBalanceConversionRate')
}

#' Get Account snapshot field
GetAccountSnapshotReportToProfitConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotReportToProfitConversionRate')
}
#' Get Account snapshot field
GetAccountSnapshotProfitToReportConversionRate<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotProfitToReportConversionRate')
}
#' Get Account snapshot field
GetAccountSnapshotReportCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountSnapshotReportCurrency')
}