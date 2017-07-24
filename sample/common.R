Filter <-function( table, columnName, pattern)
{
  isAllNegative<-T
  sapply(unlist(strsplit(pattern, ',')), function (wildcard)
  {
    if( nchar(wildcard) <= 0 )    
      return()
    if(substring(wildcard, 1,1) == '!')
    {
      wildcard<-stri_sub(wildcard, 2)
      reg<-glob2rx(wildcard)
      table<<-table[ !grepl(reg, table[,columnName, with=F][[1]])]
    }
    else
      isAllNegative<<-F
  })
  if( isAllNegative )
    return (table)
  
  unique(rbindlist(lapply(unlist(strsplit(pattern, ',')), function (wildcard)
  {
    if( nchar(wildcard) <= 0 )    
      return()
    if(substring(wildcard, 1,1) != '!')
    {
      reg<-glob2rx(wildcard)
      table[ grepl(reg, table[,columnName, with=F][[1]])]
    }
  })))
} 

GetAllTrades <- function (server, login, password, from, to, groupsFilter, excludeAccounts, skipCancelled){
  ttmConnect(server, login, password)
  trades = data.table()
  accounts = ttmGetAllAccounts()
  accounts = Filter(accounts, "Group", groupsFilter)
  excludeAcc = as.numeric(unlist(strsplit(excludeAccounts, ',')))
  excludedAccIndices<-accounts[Login %in% excludeAcc, which=T]
  if( length(excludedAccIndices) != 0)
    accounts<-accounts[-excludedAccIndices]
  trades = ttmGetTradeReports(unlist(strsplit(toString(as.integer(accounts$Login)), split = ", ")), from, to, skipCancelled)
  trades
}
