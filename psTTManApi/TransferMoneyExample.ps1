Import-Module .\ManagerModelModule.psm1 -Verbose -Force;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
#>

Connect $false

$srcAccId = 100018
$dstAccId = 100019
$currencyMap = "UST USDT BTC XBTC"

TransferMoney $srcAccId $dstAccId $currencyMap;

Disconnect;