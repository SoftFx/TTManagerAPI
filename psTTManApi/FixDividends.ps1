using namespace System.Linq

Import-Module .\ManagerModelModule.psm1;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
    Get-Help QueryBarHistoryCache -Detailed
    Get-Help QueryTickHistoryCache -Detailed
#>

Connect $false

$dividends = RequestAllDividends;

$dividends.Count.ToString() + " Dividends" | Out-File .\dividends.txt

foreach ($div in $dividends)
{
    if ($div.Rates.Count -eq 0)
    {
        continue;
    }

    $fix = $false;
    try
    {
        $gsd = [Linq.Enumerable]::ToDictionary($div.Rates, [Func[object,string]]{param($r) $r.SourceId}, [Func[object,object]]{param($r) $r});
    }
    catch
    {
        $div.ToString() | Out-File .\dividends.txt -Append
        #$fix = $true;
    }

    if ($fix)
    {
        DeleteDividend $div.Id
    }
}

Disconnect