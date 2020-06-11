#' Gets the Accounts as requested
#' @examples 
#' ttmGetAllAccounts()
#' @export
ttmGetAllAccounts <- function() {
  t1 = rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllAccounts')
  #return(GetAccountFrame)
  
  ###temp code to Get eWallet Property from CustomProperties
  PropertyTable = GetAccountsCustomProperties()
  accounts = GetAccountFrame()
  accounts = merge(accounts, PropertyTable[PropertyName == "ewallet",.(AccountId, "EWallet" = PropertyValue)], by = "AccountId", all.x = TRUE)
  ###
  return(accounts)
}

# Get Account table
GetAccountFrame<-function()
{
  AccountId = GetAccountId()
  Name = GetAccountName()
  Domain = GetAccountDomain()
  Group = GetAccountGroup()
  AccountingType = GetAccountingType()
  Blocked = GetAccountBlocked()
  Readonly = GetAccountReadonly()
  Leveage = GetAccountLeveage()
  Profit = GetAccountProfit()
  Comission = GetAccountComission()
  AgentComission = GetAccountAgentComission()
  Swap = GetAccountSwap()
  Equity = GetAccountEquity()
  Margin = GetAccountMargin()
  MarginLevel = GetAccountMarginLevel()
  Balance = GetAccountBalance()
  BalanceCurrency = GetAccountBalanceCurrency()
  MarginCallLevel = GetAccountMarginCallLevel()
  StopOutLevel = GetAccountStopOutLevel()
  IsValid = GetAccountIsValid()
  IsWebApiEnabled = GetAccountIsWebApiEnabled()
  IsTwoFactorAuthSet = GetAccountIsTwoFactorAuthSet()
  IsArchived = GetAccountIsArchived()
  FeedPriority = GetAccountFeedPriority()
  Version = GetAccountVersion()
  MarginFree = GetAccountMarginFree()
  TotalComission = GetAccountTotalComission()
  Country = GetAccountCountry()
  Email = GetAccountEmail()
  InternalComment = GetAccountInternalComment()
  data.table(AccountId,Name,Domain,Group,AccountingType,Blocked,Readonly,Leveage,Profit,Comission,AgentComission,TotalComission,Swap,
  Equity,Margin,MarginLevel,Balance,BalanceCurrency,MarginCallLevel,MarginFree,StopOutLevel,IsValid,IsWebApiEnabled,
  IsTwoFactorAuthSet,IsArchived,FeedPriority,Version,Country, Email,InternalComment)
}
#' Modify account
#' @export
ttmModifyAccount <- function(accountId,internalComment) {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'ModifyAccount',accountId,internalComment)
}
# Get Account field
GetAccountId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountId')
}
# Get Account field
GetAccountName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountName')
}
# Get Account field
GetAccountDomain<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountDomain')
}
# Get Account field
GetAccountGroup<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountGroup')
}
# Get Account field
GetAccountingType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountingType')
}
# Get Account field
GetAccountBlocked<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBlocked')
}
# Get Account field
GetAccountReadonly<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetReadonly')
}
# Get Account field
GetAccountLeveage<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetLeveage')
}
# Get Account field
GetAccountProfit<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetProfit')
}
# Get Account field
GetAccountComission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetComission')
}
# Get Account field
GetAccountAgentComission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAgentComission')
}
# Get Account field
GetAccountSwap<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSwap')
}
# Get Account field
GetAccountEquity<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetEquity')
}
# Get Account field
GetAccountMargin<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMargin')
}
# Get Account field
GetAccountMarginLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMarginLevel')
}
# Get Account field
GetAccountBalance<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBalance')
}
# Get Account field
GetAccountBalanceCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBalanceCurrency')
}
# Get Account field
GetAccountMarginCallLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMarginCallLevel')
}
# Get Account field
GetAccountStopOutLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountStopOutLevel')
}
# Get Account field
GetAccountIsValid<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetIsValid')
}
# Get Account field
GetAccountIsWebApiEnabled<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountIsWebApiEnabled')
}
# Get Account field
GetAccountIsTwoFactorAuthSet<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetIsTwoFactorAuthSet')
}
# Get Account field
GetAccountIsArchived<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetIsArchived')
}
# Get Account field
GetAccountFeedPriority<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetFeedPriority')
}
# Get Account field
GetAccountVersion<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetVersion')
}
# Get Account field
GetAccountMarginFree<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMarginFree')
}
# Get Account field
GetAccountTotalComission<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetComission')
}
# Get Account field
GetAccountCountry<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountCountry')
}
# Get Account field
GetAccountEmail<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountEmail')
}
# Get Account field
GetAccountInternalComment<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountInternalComment')
}

GetAccountCustomPropertiesId <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountCustomPropertiesId')
}

GetAccountCustomPropertiesNM <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountCustomPropertiesNM')
}

GetAccountCustomPropertiesName <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountCustomPropertiesName')
}

GetAccountCustomPropertiesValue <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountCustomPropertiesValue')
}

GetAccountsCustomProperties <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAccountsCustomProperties')
  AccountId = GetAccountCustomPropertiesId()
  PropertyNM = GetAccountCustomPropertiesNM()
  PropertyName = GetAccountCustomPropertiesName()
  PropertyValue = GetAccountCustomPropertiesValue()
  return(data.table(AccountId, PropertyNM, PropertyName, PropertyValue))
}