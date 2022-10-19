Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();
Import-Module .\ManagerModelModule.psm1 -Verbose -Force;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
#>

Connect $false


# Only these currency will be processed. Remaining will be ignored. If empty, all currencies will be processed.
$currenciesToProcess = "UST";

# Currency Mapping Rules. Format string: (x. "X1 -> Y1, X2 -> Y2"). All Volume for X1 will be withdrawn and equal Volume for Y1 will be deposited.
$currencyMap = "UST -> USDT";


# Account List will be processed. 
# $sourceAccountList = 100018, 100019;
$allAccountsInfo = RequestAllAccounts;
$sourceAccountList = $allAccountsInfo | Where-Object {$_.Assets.Currency -contains $currenciesToProcess} | Select-Object -ExpandProperty AccountId;

$Time = Get-Date;
Log "Start At $($Time.ToUniversalTime())";
Log "Parameters: currenciesToProcess - $currenciesToProcess, currencyMap - $currencyMap, SourceAccountList - $sourceAccountList";
Log "$($sourceAccountList.Count) accounts will be processed"; 

foreach($account in $sourceAccountList)
{ 
    "Process $account"; 
    $srcAccId, $dstAccId = $account, $account;
    TransferMoney $srcAccId $dstAccId $currencyMap $currenciesToProcess;
    #Start-Sleep -s 1;
}
Disconnect;

$Time = Get-Date;
Log "End At $($Time.ToUniversalTime())`n`n"