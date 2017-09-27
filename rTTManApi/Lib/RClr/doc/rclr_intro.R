## ----setup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center")

## ----methods, tidy=TRUE--------------------------------------------------
library(rClr)
clrCallStatic('Rclr.HelloWorld', 'Hello')

## ----, tidy=TRUE---------------------------------------------------------
if (tolower(Sys.info()['sysname'])=='windows') {
  # TODO: change that to a nicer prepackaged forms example. Or, allow for shorter forms for assembly names. Careful not to allow for ambiguity however.
  clrLoadAssembly("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
  f <- clrNew('System.Windows.Forms.Form')
  clrSet(f, 'Text', "Hello from the .NET framework")
  clrCall(f, 'Show')
}

## ----clrNew--------------------------------------------------------------
testClassName <- "Rclr.TestObject";
(testObj <- clrNew(testClassName))

## ----clrReflect----------------------------------------------------------
clrGetProperties(testObj)
clrGetMemberSignature(testObj, 'GetMethodWithParameters')

## ------------------------------------------------------------------------
clrCall(testObj, "GetFieldIntegerOne")
clrGetMemberSignature('Rclr.TestCases', 'CreateDateArray')

## ------------------------------------------------------------------------
dates <- clrCallStatic('Rclr.TestCases', 'CreateDateArray', '2001-01-01', as.integer(4))
str(dates)
class(dates)

## ----clrGet--------------------------------------------------------------
clrGet(testObj, "PropertyIntegerOne")
# clrSet(testObj, "PropertyIntegerOne", 1) # this would currently fail
clrSet(testObj, "PropertyIntegerOne", as.integer(1))

## ----clrGetStatic--------------------------------------------------------
# clrGetStaticMembers(testObj)
# would have the same result as:
clrGetStaticMembers('Rclr.TestObject')

## ------------------------------------------------------------------------
# the following call would fail
# clrGet(testObj,  "StaticFieldIntegerOne") 
# This is less ambiguous, and is supported
clrGet('Rclr.TestObject',  "StaticFieldIntegerOne")
clrSet('Rclr.TestObject',  "StaticFieldIntegerOne", as.integer(3))

## ----cache = F, tidy = TRUE, comment = NA, results = "asis"--------------
r_types = list(
  letters[1:3],
  as.integer(1:3),
  1:3 * 1.1,
  1:3 == 2,
  complex(real=1:3, imaginary=4:6),
  as.Date('2001-01-01') + 0:2,
  as.POSIXct('2001-01-01') + 0:2,
  as.difftime(3, units='secs') + 0:2
)

library(plyr)
conversion = lapply(r_types, rToClrType)
result <- ldply(lapply(conversion, FUN=as.data.frame))

r_vec_len_one = lapply(r_types, `[`, 1)
conversion = lapply(r_vec_len_one, rToClrType)
result2 <- ldply(lapply(conversion, FUN=as.data.frame))
result <- ldply(list(result, result2))
 
## Cannot seem to get the proper Rmarkdown with pander.
# library(pander)
# print(pander(result, style='rmarkdown'))
library(xtable)
print(xtable(result),type='html')

## ----cache = F, tidy = TRUE----------------------------------------------
# setRDotNet(TRUE)  # this should be the default package state after 0.7.0
cTypename <- "Rclr.TestCases"
clrGetMemberSignature(cTypename, "CreateRectDoubleArray")
clrCallStatic(cTypename, "CreateRectDoubleArray")

## ----cache = F, tidy = TRUE, comment = NA, results = "asis"--------------
library(stringr)
toShortTypeName <- function(x) {str_replace_all( x, ", mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089", "") }
getComplexDataCase <- function(i) {clrCallStatic(cTypename, "GetComplexDataCase", as.integer(i-1))}
getComplexDataTypeName <- function(i) {clrCallStatic(cTypename, "GetComplexDataTypeName", as.integer(i-1))}

numDataTestCases <- clrCallStatic(cTypename, "GetNumComplexDataCases")
clrTnames <- toShortTypeName(sapply(1:numDataTestCases, getComplexDataTypeName))
withConversion <- sapply(1:numDataTestCases, function(i) {class(getComplexDataCase(i))})

setConvertAdvancedTypes(FALSE)
withoutConversion <- sapply(1:numDataTestCases, function(i) {tryCatch(class(getComplexDataCase(i)), error = function(e){'Not supported'})})
setConvertAdvancedTypes(TRUE)

convSummary <- data.frame(clrType=clrTnames, enabled=withConversion, disabled=withoutConversion)

print(xtable(convSummary),type='html')

## ------------------------------------------------------------------------
testObj <- clrNew('Rclr.TestObject')
clrCall(testObj, 'TestParams', "Hello, ", "World!", 1L, 2L, 3L, 6L, 5L, 4L, 9L)
# As in C#, it also works if passing a vector
clrCall(testObj, 'TestParams', "Hello, ", "World!", 1:5)

## ------------------------------------------------------------------------
clrCall(testObj, 'TestDefaultValues', "Hello", 1L)
clrCall(testObj, 'TestDefaultValues', "Hello", 1L, 2L)
clrCall(testObj, 'TestDefaultValues', "Hello", 1L, 2L, 3L)

## ----cache = T, tidy = TRUE, comment = NA, results = "asis", fig.width=11----
perfMeasureFile <- list.files(system.file('tests', package='rClr'), pattern='performance_profiling', full.names=TRUE)
if(length(perfMeasureFile)==0) {stop('performance_profiling file not found in the installed rClr package')}
stopifnot(file.exists(perfMeasureFile[1]))
source(perfMeasureFile[1])
maxArrayLen<-7.5e6
# need to reduce the size if we run this on 32 bits machines:
if(Sys.info()['machine'] == 'x86') {maxArrayLen<-6.5e6}
trials <- createCases(numReps=10, maxArrayLen=maxArrayLen)
bench <- rclrNumericPerf(trials, tag='no.r.net')
plotRate(bench, case = 'CLR->R')
plotRate(bench, case = 'CLR->R', logy=FALSE)

## ----cache = T, tidy = TRUE, comment = NA, results = "asis", fig.width=11----
plotRate(bench, case = 'R->CLR')
plotRate(bench, case = 'R->CLR', logy=FALSE)

