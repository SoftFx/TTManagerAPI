% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Ticks.R
\name{ttmUploadQuotes}
\alias{ttmUploadQuotes}
\title{Upload Quotes}
\usage{
ttmUploadQuotes(symbol, periodicityLevel, fullFilePath)
}
\arguments{
\item{symbol}{a character. Symbol name}

\item{periodicityLevel}{a character. Periodicity Level. From this ("TicksLevel2", "Ticks" ,"M1", "H1", "VWAP")}

\item{fullFilePath}{a character. Path to Zip Quote File}
}
\description{
Upload Quotes
}
\examples{
ttmUploadQuotes("EURUSD", "M1", "C:/Quotes/EURUSD_Ticks_2019-05-24_2019-06-01.zip")

}
