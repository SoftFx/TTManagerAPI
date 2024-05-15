#' Gets the groups as requested
#' @examples 
#' ttmGetAllGroups()
#' @export
ttmGetAllGroups <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllGroups')
  GetGroupFrame()
}
# Get group table
GetGroupFrame<-function()
{
  Id = GetGroupId()
  GroupName = GetGroupName()
  Domain = GetGroupDomain()
  MarginalCallLevel = GetGroupMarginalCallLevel()
  StopOutLevel = GetGroupStopOutLevel()
  MarginLevelType = GetGroupMarginLevelType()
  RolloverType = GetGroupRolloverType()
  StopOutMode = GetGroupStopOutMode()
  Securities = GetSecurities()
  IsWebApiEnabled = GetGroupIsWebApiEnabled()
  data.table(Id,GroupName,Domain,MarginalCallLevel,StopOutLevel,MarginLevelType,RolloverType,StopOutMode,IsWebApiEnabled,Securities )
}
# Get group field
GetGroupId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetId')
}
# Get group field
GetGroupName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupName')
}
# Get group field
GetGroupDomain<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetDomain')
}
# Get group field
GetGroupMarginalCallLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMarginalCallLevel')
}
# Get group field
GetGroupStopOutLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetStopOutLevel')
}
# Get group field
GetGroupMarginLevelType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMarginLevelType')
}
# Get group field
GetGroupRolloverType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetRolloverType')
}
# Get group field
GetSecurities<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSecurities')
}
# Get group field
GetGroupStopOutMode<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetStopOutMode')
}
# Get group field
GetGroupIsWebApiEnabled<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetIsWebApiEnabled')
}

#' Gets the Groups Security Info as requested
#' @examples 
#' ttmGetAllGroupsSecurityInfo()
#' @export
ttmGetAllGroupsSecurityInfo <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllGroupsSecurityInfo')
  GetGroupSecurityFrame()
}

GetGroupSecurityFrame <- function(){
  Name = GetGroupSecurityInfoName()
  IsEnable = GetGroupSecurityInfoIsEnable()
  SecurityName = GetGroupSecurityInfoSecurityName()
  ExecutionMode = GetGroupSecurityInfoExecutionMode()
  TradeAllowed = GetGroupSecurityInfoTradeAllowed()
  MinTradeAmount = GetGroupSecurityInfoMinTradeAmount()
  MaxTradeAmount = GetGroupSecurityInfoMaxTradeAmount()
  Step = GetGroupSecurityInfoStep()
  CommissionChargeType = GetGroupSecurityInfoCommissionChargeType()
  CommissionValueType = GetGroupSecurityInfoCommissionValueType()
  TakerFee = GetGroupSecurityInfoTakerFee()
  MakerFee = GetGroupSecurityInfoMakerFee()
  Rebate = GetGroupSecurityInfoRebate()
  MinFee = GetGroupSecurityInfoMinFee()
  MinFeeCurrency = GetGroupSecurityInfoMinFeeCurrency()
  return(data.table(Name, IsEnable, SecurityName, ExecutionMode, TradeAllowed, MinTradeAmount, MaxTradeAmount, Step,
                    CommissionChargeType, CommissionValueType, TakerFee, MakerFee,
                    Rebate, MinFee, MinFeeCurrency))
}

GetGroupSecurityInfoName <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoName')
}

GetGroupSecurityInfoIsEnable <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoIsEnable')
}

GetGroupSecurityInfoSecurityName <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoSecurityName')
}
GetGroupSecurityInfoExecutionMode <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoExecutionMode')
}
GetGroupSecurityInfoTradeAllowed <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoTradeAllowed')
}
GetGroupSecurityInfoMinTradeAmount <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoMinTradeAmount')
}
GetGroupSecurityInfoMaxTradeAmount <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoMaxTradeAmount')
}
GetGroupSecurityInfoStep <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoStep')
}
GetGroupSecurityInfoCommissionChargeType <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoCommissionChargeType')
}
GetGroupSecurityInfoCommissionValueType <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoCommissionValueType')
}
GetGroupSecurityInfoTakerFee <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoTakerFee')
}
GetGroupSecurityInfoMakerFee <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoMakerFee')
}

GetGroupSecurityInfoRebate <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoRebate')
}

GetGroupSecurityInfoMinFee <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoMinFee')
}

GetGroupSecurityInfoMinFeeCurrency <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupSecurityInfoMinFeeCurrency')
}

