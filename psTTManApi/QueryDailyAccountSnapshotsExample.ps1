Import-Module .\ManagerModelModule.psm1;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
    Get-Help QueryDailyAccountSnapshots -Detailed
#>

Connect $false

$report = QueryDailyAccountSnapshots 100206 ([datetime]::new(2021, 11, 27, 0, 0, 0)) ([datetime]::new(2021, 11, 27, 23, 59, 59))
$report.Reports | Out-File .\daily_account_snapshots.txt;

Disconnect