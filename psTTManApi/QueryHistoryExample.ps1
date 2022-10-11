Import-Module .\..\ManagerModelModule.psm1;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
    Get-Help QueryBarHistoryCache -Detailed
    Get-Help QueryTickHistoryCache -Detailed
#>

Connect $true

QueryTickHistoryCache ([datetime]::new(2019, 12, 1)) 1 "EURUSD" $true;
QueryTickHistoryCache ([datetime]::new(2019, 12, 1, 1, 1, 1)) 5 "EURUSD" $true | Out-File .\tickExample.txt;

QueryBarHistoryCache ([datetime]::new(2019, 12, 1)) 1 "EURUSD" "M1" 1;
QueryBarHistoryCache ([datetime]::new(2019, 12, 1, 2, 2, 2)) 7 "EURUSD" "M1" 1 | Out-File .\barExample.txt;

Disconnect