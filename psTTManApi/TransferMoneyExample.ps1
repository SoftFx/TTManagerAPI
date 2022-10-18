Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();
Import-Module .\ManagerModelModule.psm1 -Verbose -Force;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
#>

Connect $false

# Account List will be processed. 
$sourceAccountList = 100018,100018,100018;

# Only these currency will be processed. Remaining will be ignored. If empty, all currencies will be processed.
$currenciesToProcess = "UST";

# Currency Mapping Rules. Format string: (x. "X1 -> Y1, X2 -> Y2"). All Volume for X1 will be withdrawn and equal Volume for Y1 will be deposited.
$currencyMap = "UST -> USDT";

foreach($account in $sourceAccountList)
{ 
    "Process $account"; 
    $srcAccId, $dstAccId = $account, $account;
    TransferMoney $srcAccId $dstAccId $currencyMap $currenciesToProcess;
    #Start-Sleep -s 1;
}
Disconnect;