#' Gets All Net Positions as requested
#' @examples 
#' ttmGetAllPositions()
#'
#' @export
ttmGetAllPositions <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllNetPositions')
  GetPositionsFrame()
}

# Get Positions table
GetPositionsFrame<-function()
{
  Id = GetNetPositionsId()
  AccountId = GetNetPositionsAccountId()
  Modified = GetNetPositionsModified()
  Side = GetNetPositionsSide()
  Symbol = GetNetPositionsSymbol()
  Amount = GetNetPositionsAmount()
  AveragePrice = GetNetPositionsAveragePrice()
  Profit = GetNetPositionsProfit()
  data.table(Id, AccountId, Modified, Side, Symbol, Amount, AveragePrice, Profit)
}

# GetPositions field
GetNetPositionsAccountId <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsAccountId')
}

# GetPositions field
GetNetPositionsId <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsId')
}

# GetPositions field
GetNetPositionsAmount <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsAmount')
}

# GetPositions field
GetNetPositionsAveragePrice <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsAveragePrice')
}

# GetPositions field
GetNetPositionsProfit <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsProfit')
}

# GetPositions field
GetNetPositionsSymbol <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsSymbol')
}

# GetPositions field
GetNetPositionsModified <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsModified')
}

# GetPositions field
GetNetPositionsSide <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetNetPositionsSide')
}

