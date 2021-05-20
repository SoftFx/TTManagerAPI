#' Gets All Domains
#'
#' @examples 
#' ttmGetAllDomains()
#' @export
ttmGetAllDomains <- function() {
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomains')
  GetAllDomainFrame()
}
# Get All Domain Table
GetAllDomainFrame <- function(){
  DomainName = GetAllDomainsName()
  ReportCurrency = GetAllDomainsReportCurrency()
  TokenCommissionCurrency = GetAllDomainsTokeCommCurrency()
  CompanyFullName = GetAllDomainsCompanyFullName()
  CompanyEmail = GetAllDomainsCompanyEmail()
  RestAddress = GetAllDomainsRestAddress()
  ServerAddress = GetAllDomainsServerAddress()
  RestPort = GetAllDomainsRestPort()
  PublicWebApiAccount = GetAllDomainsPublicWebApiAccount()
  data.table(DomainName, ReportCurrency, TokenCommissionCurrency, CompanyFullName, 
             CompanyEmail, RestAddress, ServerAddress, RestPort, PublicWebApiAccount)
}
# Get All Currency field
GetAllDomainsName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsName')
}
# Get All Currency field
GetAllDomainsReportCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsReportCurrency')
}
# Get All Currency field
GetAllDomainsTokeCommCurrency<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsTokeCommCurrency')
}
# Get All Currency field
GetAllDomainsCompanyFullName<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsCompanyFullName')
}
# Get All Currency field
GetAllDomainsCompanyEmail<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsCompanyEmail')
}
# Get All Currency field
GetAllDomainsRestAddress<-function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsRestAddress')
}
# Get All Currency field
GetAllDomainsServerAddress <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsServerAddress')
}
# Get All Currency field
GetAllDomainsRestPort <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsRestPort')
}
# Get All Currency field
GetAllDomainsPublicWebApiAccount <- function(){
  rClr::clrCallStatic('rTTManApi.rTTManApiHost', 'GetAllDomainsPublicWebApiAccount')
}
