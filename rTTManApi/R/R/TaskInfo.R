#' Gets the Task info (only CorporateActionFeedTasks)
#' 
#' @examples 
#' ttmGetAllCorporateActionFeedTasks()
#' 
#' @export
ttmGetAllCorporateActionFeedTasks <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllCorporateActionFeedTasks')
  return(data.table(
    Name = GetTaskNames(),
    Module = GetTaskModules(),
    TaskID = GetTaskIDs(),
    Trigger = GetTaskTriggers(),
    SourceURL = GetTaskSourceURLs(),
    SecurityList = GetTaskSecurityList(),
    SymbolMapping = GetTaskSymbolMappings()
  ))
}

GetTaskNames <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTaskNames')
}

GetTaskModules <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTaskModules')
}

GetTaskIDs <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTaskIDs')
}

GetTaskTriggers <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTaskTriggers')
}

GetTaskSourceURLs <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTaskSourceURLs')
}

GetTaskSecurityList <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTaskSecurityList')
}

GetTaskSymbolMappings <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetTaskSymbolMappings')
}