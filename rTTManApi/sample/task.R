Sys.setenv(RSTUDIO_PANDOC="C:/Program Files/RStudio/bin/pandoc")
outputDir<-file.path(getwd(), "reports", Sys.Date())
if( dir.exists(outputDir))
  unlink(outputDir, recursive = T)
dir.create(outputDir, recursive =T )

csvDir<-file.path(getwd(), ".csv", Sys.Date())
if( dir.exists(csvDir))
  unlink(csvDir, recursive = T)
dir.create(csvDir, recursive =T )

#Creds
server1<- "exchange.tts.st.soft-fx.eu"
login1<- "12350"
password1 <- "123qwe!"

#Params and filters
startDate1 <- "2017-06-21"
endDate1 <- "2017-07-24"
groupsFilter1 <- "Test*"
excludeAccounts1 = "100180,100183,100184,100185,100186"
skipCancelled1 <- FALSE
path1 <- csvDir 

library(lubridate)
startDate = as.Date(startDate1)
endDate = as.Date(endDate1)
for(i in 1:as.integer(endDate - startDate)) {
  rmarkdown::render(input = "TradeReports.Rmd", output_file = paste("TradeReports from ", startDate, " to ", (startDate+days(1)), ".html"), params=list(server=server1, login=login1, password = password1, startDate = toString(startDate), groupsFilter = groupsFilter1, excludeAccounts = excludeAccounts1, skipCancelled = skipCancelled1, path = path1), output_dir=file.path(outputDir))
  startDate = startDate + days(1)
}
