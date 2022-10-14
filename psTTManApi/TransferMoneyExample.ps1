﻿Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();
Import-Module .\ManagerModelModule.psm1 -Verbose -Force;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
#>

Connect $false

$sourceAccountList = 100018,100018,100018,100018,100018,100018,100018,100018,100018,100018,100018;

$currenciesToProcessTotal = "UST";
$currencyMapTotal = "UST -> USDT";

$i = 0;
foreach($account in $sourceAccountList)
{ 
    $srcAccId, $dstAccId = $account, $account;
    TransferMoney $srcAccId $dstAccId $currencyMapTotal $currenciesToProcessTotal;
    $scrAccId, $dstAccId = $dstAccId, $srcAccId;
    #Start-Sleep -s 1;
}
Disconnect;