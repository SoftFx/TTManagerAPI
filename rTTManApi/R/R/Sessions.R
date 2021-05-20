#' Gets All Online Sessions
#'
#' @examples 
#' ttmGetAllOnlineSessions()
#' @export
ttmGetAllOnlineSessions <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllOnlineSessions')
  GetAllSessionsFrame()
}
# Get All Online Table
GetAllSessionsFrame <- function(){
  SessionId = GetOnlineSessionId()
  AccountId = GetOnlineSessionAccountId()
  Group = GetOnlineSessionAccountGroup()
  Type = GetOnlineSessionType()
  ManagerType = GetOnlineSessionManagerType()
  Ip = GetOnlineSessionIp()
  TimeCreated = GetOnlineSessionTimeCreated()
  data.table(SessionId, AccountId, Group, Type, ManagerType, Ip, TimeCreated)
}
# Get All Sessions field
GetOnlineSessionId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOnlineSessionId')
}
# Get All Sessions field
GetOnlineSessionAccountId<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOnlineSessionAccountId')
}
# Get All Sessions field
GetOnlineSessionAccountGroup<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOnlineSessionAccountGroup')
}
# Get All Sessions field
GetOnlineSessionType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOnlineSessionType')
}

# Get All Sessions field
GetOnlineSessionManagerType<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOnlineSessionManagerType')
}

# Get All Sessions field
GetOnlineSessionIp<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOnlineSessionIp')
}
# Get All Sessions field
GetOnlineSessionTimeCreated<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetOnlineSessionTimeCreated')
}
