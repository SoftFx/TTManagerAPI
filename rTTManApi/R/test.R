library(rTTManApi)

ttmConnect("tt.tt-ag.st.soft-fx.eu", "1", "123qwe!")
# ttmConnect("alpha.tts.st.soft-fx.eu", "94", "123qwe!")

snap <- ttmGetAccountSnaphots(100040, as.POSIXct("2021-12-02"), as.POSIXct("2021-12-08"))

pos <- ttmGetPositionSnaphots(100040, as.POSIXct("2021-12-02"), as.POSIXct("2021-12-09"))
assets <- ttmGetAssetSnapshots(100040, as.POSIXct("2021-12-02"), as.POSIXct("2021-12-04"))
orders <- ttmGetOrderSnapshots(100040, as.POSIXct("2021-12-02"), as.POSIXct("2021-12-08"))
ttmDisconnect()

t <- ttmGetAllOrders()




r <- ttmGetTradeReports(100007, from = as.POSIXct("2021-08-01"), to = Sys.time(), getStringPosId = TRUE)


ttmConnect("ttlive.soft-fx.com", "40", "9cPceEgEXr7f")
trades <- ttmGetTradeReports(25000005, from = as.POSIXct("2021-12-05"), to = as.POSIXct("2021-12-07"), getStringPosId = TRUE)
ttmDisconnect()
