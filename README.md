# TTManagerAPI

Manager Interface for TT

# How to install/update it?
```
install.packages("devtools")		
install.packages("install.load")		
library(install.load)		
install_load("data.table", "stringi")		
		
installRPackage <- function(url){		
  package = basename(url)		
  download.file(url, destfile = package)		
  install.packages(package, repos = NULL, type = "source")		
  file.remove(package)		
}		
installRPackage("https://github.com/SoftFx/TTManagerAPI/raw/master/rTTManApi/Lib/RClr/rClr_0.7-4.zip");		
if(require(rTTManApi)) {		
  remove.packages("rTTManApi")		
}else{		
  require(devtools)		
  install_github("SoftFx/TTManagerAPI",subdir = "rTTManApi/R")		
}
```
# Examples of using rTTManApi functions
see examples [here](http://rpubs.com/mys1997mail/310679)
