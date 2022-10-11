#' Gets the Schedule OffTimes requested
#' 
#' @examples 
#' ttmGetScheduleInfo()
#' 
#' @export
ttmGetScheduleInfo <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleInfo')
  return(data.table(
    ScheduleId = GetScheduleId(),
    ScheduleName = GetScheduleName(),
    ScheduleDescription = GetScheduleDescription(),
    RelatedSchedule = GetScheduleRelatedSchedules(),
    TimeZoneId = GetScheduleTimezoneId(),
    OffTimeName = GetScheduleOffTimeName(),
    OffTimeDescription = GetScheduleOffTimeDescription(),
    OffTimePeriodicity = GetScheduleOffTimePeriodicity(),
    OffTimeOffset = GetScheduleOffTimeOffset(),
    OffTimeDuration = GetScheduleOffTimeDuration(),
    OffTimeDisabledFeatures = GetScheduleOffTimeDisabledFeatures(),
    BaseUTCOffsetSec = GetBaseUTCOffsetSec(),
    IsSupportDST = GetIsSupportDST(),
    UTCOffsetSec = GetUTCOffsetSec()
  ))
}

GetScheduleId <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleId')
}
GetScheduleName <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleName')
}
GetScheduleDescription <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleDescription')
}
GetScheduleRelatedSchedules <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleRelatedSchedules')
}
GetScheduleTimezoneId <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleTimezoneId')
}
GetScheduleOffTimeName <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleOffTimeName')
}
GetScheduleOffTimeDescription <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleOffTimeDescription')
}
GetScheduleOffTimePeriodicity <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleOffTimePeriodicity')
}
GetScheduleOffTimeOffset <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleOffTimeOffset')
}
GetScheduleOffTimeDuration <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleOffTimeDuration')
}
GetScheduleOffTimeDisabledFeatures <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetScheduleOffTimeDisabledFeatures')
}
GetBaseUTCOffsetSec <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetBaseUTCOffsetSec')
}
GetIsSupportDST <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetIsSupportDST')
}
GetUTCOffsetSec <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetUTCOffsetSec')
}

#' Gets the Windows System TZ
#' 
#' @examples 
#' ttmGetSystemTZInfo()
#' 
#' @export
ttmGetSystemTZInfo <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSystemTZInfo')
  return(data.table(
    SystemTZId = GetSystemTZId(),
    SystemTZDisplayName = GetSystemTZDisplayName(),
    SystemTZIsSupportsDST = GetSystemTZIsSupportsDST(),
    SystemTZBaseOffsetSec = GetSystemTZBaseOffsetSec()
  ))
}

GetSystemTZId <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSystemTZId')
}
GetSystemTZDisplayName <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSystemTZDisplayName')
}
GetSystemTZIsSupportsDST <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSystemTZIsSupportsDST')
}
GetSystemTZBaseOffsetSec <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetSystemTZBaseOffsetSec')
}