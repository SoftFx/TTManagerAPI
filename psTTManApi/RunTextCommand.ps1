Import-Module .\ManagerModelModule.psm1;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
    Get-Help RunTextCommand -Detailed
#>

Connect $true

Write-Output (RunTextCommand "account info id=100").GetAwaiter().GetResult().OutputText;

Disconnect
