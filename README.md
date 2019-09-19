# TTManagerAPI

Manager Interface for TT

# How to install/update it?
```
if(!require(devtools)) {install.packages("devtools"); library(devtools)}
if(!require(rClr)){install.packages("https://github.com/SoftFx/TTManagerAPI/raw/master/rTTManApi/Lib/RClr/rClr_0.8.3.zip",repos = NULL)}		
if(require(rTTManApi)) {detach("package:rTTManApi", unload=TRUE); remove.packages("rTTManApi")}
install_github("SoftFx/TTManagerAPI",subdir = "rTTManApi/R")		
```
# Examples of using rTTManApi functions
see examples [here](http://rpubs.com/mys1997mail/310679)
