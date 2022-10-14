Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();
Import-Module .\ManagerModelModule.psm1 -Verbose -Force;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
#>

Connect $false

#$srcAccId = 100018
#$dstAccId = 100018

$sourceAccountList = 100018,100018,100018,100018,100018,100018,100018,100018,100018,100018,100018;

$currenciesToProcessTotal = "UST", "USDT";
$currencyMapTotal = "UST -> USDT", "USDT -> UST"

$i = 0;
foreach($account in $sourceAccountList)
{ 
    
    $i;
    $srcAccId, $dstAccId = $account, $account;
    TransferMoney $srcAccId $dstAccId $currencyMapTotal[$i % 2] $currenciesToProcessTotal[$i % 2];
    $scrAccId, $dstAccId = $dstAccId, $srcAccId;
    $i += 1;
    #Start-Sleep -s 1;
}
Disconnect;