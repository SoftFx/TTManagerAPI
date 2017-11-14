if(!require(devtools)) {install.packages("devtools"); library(devtools)}
if(!require(rClr)){install.packages("https://github.com/SoftFx/TTManagerAPI/raw/master/rTTManApi/Lib/RClr/rClr_0.7-4.zip",repos = NULL)}		
if(require(rTTManApi)) {detach("package:rTTManApi", unload=TRUE); remove.packages("rTTManApi")}
install_github("SoftFx/TTManagerAPI",subdir = "rTTManApi/R")