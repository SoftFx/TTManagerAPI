#' Gets the groups as requested
#'
#' @export
ttmGetAllGroups <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllGroups')
  GetGroupFrame()
}
#' Get group table
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
#' Get group field
GetGroupId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetId')
}
#' Get group field
GetGroupName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetGroupName')
}
#' Get group field
GetGroupDomain<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetDomain')
}
#' Get group field
GetGroupMarginalCallLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMarginalCallLevel')
}
#' Get group field
GetGroupStopOutLevel<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetStopOutLevel')
}
#' Get group field
GetGroupMarginLevelType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetMarginLevelType')
}
#' Get group field
GetGroupRolloverType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetRolloverType')
}
#' Get group field
GetSecurities<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSecurities')
}
#' Get group field
GetGroupStopOutMode<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetStopOutMode')
}
#' Get group field
GetGroupIsWebApiEnabled<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetIsWebApiEnabled')
}