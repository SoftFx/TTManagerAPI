$config = ([xml](Get-Content .\config.xml)).root;
Add-Type -Path (Join-Path $config.libPath "TickTrader.Manager.Model.dll");
Add-Type -Path (Join-Path $config.libPath "TickTrader.BusinessObjects.dll");

$mm = New-Object TickTrader.Manager.Model.TickTraderManagerModel;

function Connect{
    param([bool]$enablePumping)
    "Connect: " + $config.login + "@" + $config.address
    $connected = $mm.connect($config.address, $config.login, $config.password);

    if (!$connected)
    {
        $tfa = Read-Host -Prompt "Enter 2FA passcode"
        $mm.SetupTwoFactorPasscode($tfa);
        $connected = $true;
    }

    "Connected: " + $connected;

    if ($enablePumping)
    {
        "Enable pumping: " + $mm.EnablePumping();
    }

    <#
    .DESCRIPTION
    Connect to server via ManagerModel interface.
    You should set credentials and module path in config.xml file.
    #>
}

function Disconnect{
    Start-Sleep -s 1;
    "Disconnected: " + $mm.Disconnect();
}

function RunTextCommand{
    param([string]$command);

    Start-Sleep -s 1;
    $mm.TextCommand($command);

    <#

    .DESCRIPTION

    Run text command.

    .PARAMETER command
    Specifies a text command.


    .OUTPUTS

    Returns TextCommandResponse

    .EXAMPLE

    PS> RunTextCommand "account info id=5"


    .EXAMPLE

    PS> RunTextCommand "account info id=5" | Out-File .\RunTextCommandExample.txt;


    #>
}
function QueryBarHistoryCache{
    param([datetime]$date, [int]$maxBars, [string]$symbol, [string]$pereodicity, [int]$isAsk);

    Start-Sleep -s 1;
    $mm.QueryBarHistoryCache($date, $maxBars, $symbol, $pereodicity, $isAsk);

    <#

    .DESCRIPTION

    Query bars from history cache.

    .PARAMETER isAsk
    Specifies ask or bid bars types. 0 - Bid, 1 - Ask.


    .OUTPUTS

    Returns list of HistoryBar

    .EXAMPLE

    PS> QueryBarHistoryCache ([datetime]::new(2019, 12, 1)) 1 "EURUSD" "M1" 1


    .EXAMPLE

    PS> QueryBarHistoryCache ([datetime]::new(2019, 12, 1, 2, 2, 2)) 7 "EURUSD" "M1" 1 | Out-File .\barExample.txt;


    #>
}

function QueryTickHistoryCache{
    param([datetime]$date, [int]$maxTicks, [string]$symbol, [bool]$includeLevel2);

    Start-Sleep -s 1;
    $mm.QueryTickHistoryCache($date, $maxTicks, $symbol, $includeLevel2);
    
    <#

    .DESCRIPTION

    Query ticks from history cache.


    .OUTPUTS

    Returns list of TickValue

    .EXAMPLE

    PS> QueryTickHistoryCache ([datetime]::new(2019, 12, 1)) 1 "EURUSD" $true;

    .EXAMPLE

    PS> QueryTickHistoryCache ([datetime]::new(2019, 12, 1, 1, 1, 1)) 5 "EURUSD" $true | Out-File .\tickExample.txt;


    #>
}

function CreateContingentOrderSinlgeOrderSingleTrigger{
    param([long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side, [TickTrader.BusinessObjects.OrderTypes]$type, [decimal]$amount, [decimal]$price, [decimal]$stopprice,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType, [long]$orderId, [datetime]$time, [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest.AccountId = $acc;
    $orderrequest.Side = $side;
    $orderrequest.Type = $type;
    $orderrequest.Symbol = $symbol;
    $orderrequest.Price = $price;
    $orderrequest.StopPrice = $stopprice;
    $orderrequest.ManagerOptions = $options;
    $orderrequest.Amount = $amount;

    $trigger = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger.TriggerType = $triggerType;
    $trigger.OrderIdTriggeredBy = $orderId;
    $trigger.TriggerTime = $time;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderNewRequest;
    $request.TradeRequest = $orderrequest;
    $request.Triggers.Add($trigger);
    $request.AccountId = $acc;
    $mm.CreateContingentOrder($request);
}

function CreateContingentOrderSinlgeOrderTwoTriggers{
    param([long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side, [TickTrader.BusinessObjects.OrderTypes]$type, [decimal]$amount, [decimal]$price, [decimal]$stopprice,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType1, [long]$orderId1, [datetime]$time1, 
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType2, [long]$orderId2, [datetime]$time2,
    [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest.AccountId = $acc;
    $orderrequest.Side = $side;
    $orderrequest.Type = $type;
    $orderrequest.Symbol = $symbol;
    $orderrequest.Price = $price;
    $orderrequest.StopPrice = $stopprice;
    $orderrequest.ManagerOptions = $options;
    $orderrequest.Amount = $amount;

    $trigger1 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger1.TriggerType = $triggerType1;
    $trigger1.OrderIdTriggeredBy = $orderId1;
    $trigger1.TriggerTime = $time1;

    $trigger2 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger2.TriggerType = $triggerType2;
    $trigger2.OrderIdTriggeredBy = $orderId2;
    $trigger2.TriggerTime = $time2;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderNewRequest;
    $request.TradeRequest = $orderrequest;
    $request.Triggers.Add($trigger1);
    $request.Triggers.Add($trigger2);
    $request.AccountId = $acc;
    $mm.CreateContingentOrder($request);
}

function CreateContingentOrderOcoOrdersSingleTrigger{
    param([long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side1, [TickTrader.BusinessObjects.OrderTypes]$type1, [decimal]$amount1, [decimal]$price1, [decimal]$stopprice1,
    [TickTrader.BusinessObjects.OrderSides]$side2, [TickTrader.BusinessObjects.OrderTypes]$type2, [decimal]$amount2, [decimal]$price2, [decimal]$stopprice2,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType, [long]$orderId, [datetime]$time, [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest1 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest1.AccountId = $acc;
    $orderrequest1.Side = $side1;
    $orderrequest1.Type = $type1;
    $orderrequest1.Symbol = $symbol;
    $orderrequest1.Price = $price1;
    $orderrequest1.StopPrice = $stopprice1;
    $orderrequest1.ManagerOptions = $options;
    $orderrequest1.Amount = $amount1;

    $orderrequest2 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest2.AccountId = $acc;
    $orderrequest2.Side = $side2;
    $orderrequest2.Type = $type2;
    $orderrequest2.Symbol = $symbol;
    $orderrequest2.Price = $price2;
    $orderrequest2.StopPrice = $stopprice2;
    $orderrequest2.ManagerOptions = $options;
    $orderrequest2.Amount = $amount2;

    $ocorequest = New-Object TickTrader.BusinessObjects.Requests.OpenOCOOrdersRequest;
    $ocorequest.AccountId = $acc;
    $ocorequest.FirstRequest = $orderrequest1;
    $ocorequest.SecondRequest = $orderrequest2;
    $ocorequest.ManagerOptions = $options;

    $trigger = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger.TriggerType = $triggerType;
    $trigger.OrderIdTriggeredBy = $orderId;
    $trigger.TriggerTime = $time;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderNewRequest;
    $request.TradeRequest = $ocorequest;
    $request.Triggers.Add($trigger);
    $request.AccountId = $acc;
    $mm.CreateContingentOrder($request);
}

function CreateContingentOrderOcoOrdersTwoTriggers{
    param([long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side1, [TickTrader.BusinessObjects.OrderTypes]$type1, [decimal]$amount1, [decimal]$price1, [decimal]$stopprice1,
    [TickTrader.BusinessObjects.OrderSides]$side2, [TickTrader.BusinessObjects.OrderTypes]$type2, [decimal]$amount2, [decimal]$price2, [decimal]$stopprice2,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType1, [long]$orderId1, [datetime]$time1, 
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType2, [long]$orderId2, [datetime]$time2,
    [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest1 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest1.AccountId = $acc;
    $orderrequest1.Side = $side1;
    $orderrequest1.Type = $type1;
    $orderrequest1.Symbol = $symbol;
    $orderrequest1.Price = $price1;
    $orderrequest1.StopPrice = $stopprice1;
    $orderrequest1.ManagerOptions = $options;
    $orderrequest1.Amount = $amount1;

    $orderrequest2 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest2.AccountId = $acc;
    $orderrequest2.Side = $side2;
    $orderrequest2.Type = $type2;
    $orderrequest2.Symbol = $symbol;
    $orderrequest2.Price = $price2;
    $orderrequest2.StopPrice = $stopprice2;
    $orderrequest2.ManagerOptions = $options;
    $orderrequest2.Amount = $amount2;

    $ocorequest = New-Object TickTrader.BusinessObjects.Requests.OpenOCOOrdersRequest;
    $ocorequest.AccountId = $acc;
    $ocorequest.FirstRequest = $orderrequest1;
    $ocorequest.SecondRequest = $orderrequest2;
    $ocorequest.ManagerOptions = $options;

    $trigger1 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger1.TriggerType = $triggerType1;
    $trigger1.OrderIdTriggeredBy = $orderId1;
    $trigger1.TriggerTime = $time1;

    $trigger2 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger2.TriggerType = $triggerType2;
    $trigger2.OrderIdTriggeredBy = $orderId2;
    $trigger2.TriggerTime = $time2;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderNewRequest;
    $request.TradeRequest = $ocorequest;
    $request.Triggers.Add($trigger1);
    $request.Triggers.Add($trigger2);
    $request.AccountId = $acc;
    $mm.CreateContingentOrder($request);
}

function ModifyContingentOrderSingleTrigger{
    param([long]$id, [long]$acc, [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType1, [long]$orderId1, [datetime]$time1);
    Start-Sleep -s 1;

    $trigger1 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger1.TriggerType = $triggerType1;
    $trigger1.OrderIdTriggeredBy = $orderId1;
    $trigger1.TriggerTime = $time1;
    
    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.Triggers.Add($trigger1);
    $request.AccountId = $acc;
    $request.Id = $id;
    $mm.ModifyContingentOrder($request);
}

function ModifyContingentOrderTwoTriggers{
    param([long]$id, [long]$acc, [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType1, [long]$orderId1, [datetime]$time1,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType2, [long]$orderId2, [datetime]$time2);
    Start-Sleep -s 1;

    $trigger1 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger1.TriggerType = $triggerType1;
    $trigger1.OrderIdTriggeredBy = $orderId1;
    $trigger1.TriggerTime = $time1;

    $trigger2 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger2.TriggerType = $triggerType2;
    $trigger2.OrderIdTriggeredBy = $orderId2;
    $trigger2.TriggerTime = $time2;
    
    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.Triggers.Add($trigger1);
    $request.Triggers.Add($trigger2);
    $request.Id = $id;
    $request.AccountId = $acc;
    $mm.ModifyContingentOrder($request);
}

function ModifyContingentOrderSingleOrder{
    param([long]$id, [long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side1, [TickTrader.BusinessObjects.OrderTypes]$type1, [decimal]$amount1, [decimal]$price1, [decimal]$stopprice1, [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);
    Start-Sleep -s 1;

    $orderrequest1 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest1.AccountId = $acc;
    $orderrequest1.Side = $side1;
    $orderrequest1.Type = $type1;
    $orderrequest1.Symbol = $symbol;
    $orderrequest1.Price = $price1;
    $orderrequest1.StopPrice = $stopprice1;
    $orderrequest1.ManagerOptions = $options;
    $orderrequest1.Amount = $amount1;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.TradeRequest = $orderrequest1;
    $request.Id = $id;
    $request.AccountId = $acc;
    $mm.ModifyContingentOrder($request);
}

function ModifyContingentOrderOcoOrders{
    param([long]$id, [long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side1, [TickTrader.BusinessObjects.OrderTypes]$type1, [decimal]$amount1, [decimal]$price1, [decimal]$stopprice1, 
    [TickTrader.BusinessObjects.OrderSides]$side2, [TickTrader.BusinessObjects.OrderTypes]$type2, [decimal]$amount2, [decimal]$price2, [decimal]$stopprice2, [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);
    Start-Sleep -s 1;

    $orderrequest1 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest1.AccountId = $acc;
    $orderrequest1.Side = $side1;
    $orderrequest1.Type = $type1;
    $orderrequest1.Symbol = $symbol;
    $orderrequest1.Price = $price1;
    $orderrequest1.StopPrice = $stopprice1;
    $orderrequest1.ManagerOptions = $options;
    $orderrequest1.Amount = $amount1;

    $orderrequest2 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest2.AccountId = $acc;
    $orderrequest2.Side = $side2;
    $orderrequest2.Type = $type2;
    $orderrequest2.Symbol = $symbol;
    $orderrequest2.Price = $price2;
    $orderrequest2.StopPrice = $stopprice2;
    $orderrequest2.ManagerOptions = $options;
    $orderrequest2.Amount = $amount2;

    $ocorequest = New-Object TickTrader.BusinessObjects.Requests.OpenOCOOrdersRequest;
    $ocorequest.AccountId = $acc;
    $ocorequest.FirstRequest = $orderrequest1;
    $ocorequest.SecondRequest = $orderrequest2;
    $ocorequest.ManagerOptions = $options;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.TradeRequest = $ocorequest;
    $request.Id = $id;
    $request.AccountId = $acc;
    $mm.ModifyContingentOrder($request);
}

function ModifyContingentOrderSinlgeOrderSingleTrigger{
    param([long]$id, [long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side, [TickTrader.BusinessObjects.OrderTypes]$type, [decimal]$amount, [decimal]$price, [decimal]$stopprice,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType, [long]$orderId, [datetime]$time, [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest.AccountId = $acc;
    $orderrequest.Side = $side;
    $orderrequest.Type = $type;
    $orderrequest.Symbol = $symbol;
    $orderrequest.Price = $price;
    $orderrequest.StopPrice = $stopprice;
    $orderrequest.ManagerOptions = $options;
    $orderrequest.Amount = $amount;

    $trigger = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger.TriggerType = $triggerType;
    $trigger.OrderIdTriggeredBy = $orderId;
    $trigger.TriggerTime = $time;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.TradeRequest = $orderrequest;
    $request.Triggers.Add($trigger);
    $request.Id = $id;
    $request.AccountId = $acc;
    $mm.ModifyContingentOrder($request);
}

function ModifyContingentOrderSinlgeOrderTwoTriggers{
    param([long]$id, [long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side, [TickTrader.BusinessObjects.OrderTypes]$type, [decimal]$amount, [decimal]$price, [decimal]$stopprice,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType1, [long]$orderId1, [datetime]$time1, 
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType2, [long]$orderId2, [datetime]$time2,
    [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest.AccountId = $acc;
    $orderrequest.Side = $side;
    $orderrequest.Type = $type;
    $orderrequest.Symbol = $symbol;
    $orderrequest.Price = $price;
    $orderrequest.StopPrice = $stopprice;
    $orderrequest.ManagerOptions = $options;
    $orderrequest.Amount = $amount;

    $trigger1 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger1.TriggerType = $triggerType1;
    $trigger1.OrderIdTriggeredBy = $orderId1;
    $trigger1.TriggerTime = $time1;

    $trigger2 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger2.TriggerType = $triggerType2;
    $trigger2.OrderIdTriggeredBy = $orderId2;
    $trigger2.TriggerTime = $time2;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.TradeRequest = $orderrequest;
    $request.Triggers.Add($trigger1);
    $request.Triggers.Add($trigger2);
    $request.AccountId = $acc;
    $request.Id = $id;
    $mm.ModifyContingentOrder($request);
}

function ModifyContingentOrderOcoOrdersSingleTrigger{
    param([long]$id, [long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side1, [TickTrader.BusinessObjects.OrderTypes]$type1, [decimal]$amount1, [decimal]$price1, [decimal]$stopprice1,
    [TickTrader.BusinessObjects.OrderSides]$side2, [TickTrader.BusinessObjects.OrderTypes]$type2, [decimal]$amount2, [decimal]$price2, [decimal]$stopprice2,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType, [long]$orderId, [datetime]$time, [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest1 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest1.AccountId = $acc;
    $orderrequest1.Side = $side1;
    $orderrequest1.Type = $type1;
    $orderrequest1.Symbol = $symbol;
    $orderrequest1.Price = $price1;
    $orderrequest1.StopPrice = $stopprice1;
    $orderrequest1.ManagerOptions = $options;
    $orderrequest1.Amount = $amount1;

    $orderrequest2 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest2.AccountId = $acc;
    $orderrequest2.Side = $side2;
    $orderrequest2.Type = $type2;
    $orderrequest2.Symbol = $symbol;
    $orderrequest2.Price = $price2;
    $orderrequest2.StopPrice = $stopprice2;
    $orderrequest2.ManagerOptions = $options;
    $orderrequest2.Amount = $amount2;

    $ocorequest = New-Object TickTrader.BusinessObjects.Requests.OpenOCOOrdersRequest;
    $ocorequest.AccountId = $acc;
    $ocorequest.FirstRequest = $orderrequest1;
    $ocorequest.SecondRequest = $orderrequest2;
    $ocorequest.ManagerOptions = $options;

    $trigger = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger.TriggerType = $triggerType;
    $trigger.OrderIdTriggeredBy = $orderId;
    $trigger.TriggerTime = $time;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.TradeRequest = $ocorequest;
    $request.Triggers.Add($trigger);
    $request.AccountId = $acc;
    $request.Id = $id;
    $mm.ModifyContingentOrder($request);
}

function ModifyContingentOrderOcoOrdersTwoTriggers{
    param([long]$id, [long]$acc, [string]$symbol, [TickTrader.BusinessObjects.OrderSides]$side1, [TickTrader.BusinessObjects.OrderTypes]$type1, [decimal]$amount1, [decimal]$price1, [decimal]$stopprice1,
    [TickTrader.BusinessObjects.OrderSides]$side2, [TickTrader.BusinessObjects.OrderTypes]$type2, [decimal]$amount2, [decimal]$price2, [decimal]$stopprice2,
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType1, [long]$orderId1, [datetime]$time1, 
    [TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]$triggerType2, [long]$orderId2, [datetime]$time2,
    [TickTrader.BusinessObjects.Requests.TradeRequestOptions]$options);

    Start-Sleep -s 1;
    $orderrequest1 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest1.AccountId = $acc;
    $orderrequest1.Side = $side1;
    $orderrequest1.Type = $type1;
    $orderrequest1.Symbol = $symbol;
    $orderrequest1.Price = $price1;
    $orderrequest1.StopPrice = $stopprice1;
    $orderrequest1.ManagerOptions = $options;
    $orderrequest1.Amount = $amount1;

    $orderrequest2 = New-Object TickTrader.BusinessObjects.Requests.OpenOrderRequest;
    $orderrequest2.AccountId = $acc;
    $orderrequest2.Side = $side2;
    $orderrequest2.Type = $type2;
    $orderrequest2.Symbol = $symbol;
    $orderrequest2.Price = $price2;
    $orderrequest2.StopPrice = $stopprice2;
    $orderrequest2.ManagerOptions = $options;
    $orderrequest2.Amount = $amount2;

    $ocorequest = New-Object TickTrader.BusinessObjects.Requests.OpenOCOOrdersRequest;
    $ocorequest.AccountId = $acc;
    $ocorequest.FirstRequest = $orderrequest1;
    $ocorequest.SecondRequest = $orderrequest2;
    $ocorequest.ManagerOptions = $options;

    $trigger1 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger1.TriggerType = $triggerType1;
    $trigger1.OrderIdTriggeredBy = $orderId1;
    $trigger1.TriggerTime = $time1;

    $trigger2 = New-Object TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerInfo;
    $trigger2.TriggerType = $triggerType2;
    $trigger2.OrderIdTriggeredBy = $orderId2;
    $trigger2.TriggerTime = $time2;

    $request = New-Object TickTrader.BusinessObjects.Requests.ContingentOrderModifyRequest;
    $request.TradeRequest = $ocorequest;
    $request.Triggers.Add($trigger1);
    $request.Triggers.Add($trigger2);
    $request.Id = $id;
    $request.AccountId = $acc;
    $mm.ModifyContingentOrder($request);
}

function QueryDailyAccountSnapshots{
    param([long]$accountId, [datetime]$fromDate, [datetime]$toDate);

    $request = New-Object TickTrader.BusinessObjects.Requests.DailyAccountsSnapshotRequest;
    $request.AccountIds = New-Object System.Collections.Generic.List[long];
    $request.AccountIds.Add($accountId);
    $request.fromDate = $fromDate;
    $request.toDate = $toDate;
    $request.IsUTC = $true;
    $request.Streaming.Direction = [TickTrader.BusinessObjects.StreamingDirections]::Forward;

    $mm.QueryDailyAccountsSnapshot($request);

    <#

    .DESCRIPTION

    Query an account daily snapshots.

    .PARAMETER accountId
    Specifies an account Id.

    .PARAMETER fromDate
    Specifies date from.

    .PARAMETER toDate
    Specifies date to.
    
    .OUTPUTS

    Returns DailyAccountsSnapshotReport

    .EXAMPLE

    PS> QueryDailyAccountSnapshots 100206 ([datetime]::new(2021, 11, 27, 0, 0, 0)) ([datetime]::new(2021, 11, 27, 23, 59, 59))
    
    .EXAMPLE

    PS> QueryDailyAccountSnapshots 100206 ([datetime]::new(2021, 11, 27, 0, 0, 0)) ([datetime]::new(2021, 11, 27, 23, 59, 59)) | Out-File .\daily_account_snapshots.txt;

    #>
}

function GetAllDividends{

    $mm.GetAllDividends();

}

function RequestAllDividends{

    $mm.RequestAllDividends();

}

function DeleteDividend{
    param([long]$dividendId)

    $mm.DeleteDividend($dividendId);
}

function TransferMoneyMethod{
    param([System.Collections.Generic.List[TickTrader.BusinessObjects.AccountInfo]]$souceAccountInfo,`
            [System.Collections.Generic.List[TickTrader.BusinessObjects.AccountInfo]]$destAccountInfo,`
            [System.Collections.Generic.List[string]]$currencyToProcessList1);

    Start-Sleep -s 1;
    
    $sourceAccountId = $souceAccountInfo.AccountId;
    $destAccountId = $destAccountInfo.AccountId;
    $srcAccType = $souceAccountInfo.AccountingType.Value;
    $dstAccType = $destAccountInfo.AccountingType.Value

    if($srcAccType -ne [TickTrader.BusinessObjects.AccountingTypes]::Cash)
    {
        if($currencyToProcessList1.Count -gt 0 -and $souceAccountInfo.BalanceCurrency -in $currencyToProcessList1 -or $currencyToProcessList1.Count -eq 0)
        {
            $request = New-Object TickTrader.BusinessObjects.Requests.TransferMoneyRequest;
            $request.SrcAccount = $sourceAccountId;
            $request.DstAccount = $destAccountId;
            $request.Amount = $souceAccountInfo.Balance;
            $request.Currency = $souceAccountInfo.BalanceCurrency;
            $request.Comment = "";
            try{
                $mm.TransferMoney($request);
            }
            catch{
                "Error During Transfer Money {$request}"
            }
        }
    }
    else
    {
        if($srcAccType -eq [TickTrader.BusinessObjects.AccountingTypes]::Cash -and $dstAccType -eq [TickTrader.BusinessObjects.AccountingTypes]::Cash)
        {
            $assetsToProcess = $souceAccountInfo.Assets;
            if($currencyToProcessList1.Count -gt 0){
                $assetsToProcess = $assetsToProcess | Where-Object -Property Currency -In $currencyToProcessList1;
                "Only {$assetsToProcess} will be proccessed";
            }
            foreach($asset in $assetsToProcess)
            {
                $request = New-Object TickTrader.BusinessObjects.Requests.TransferMoneyRequest;
                $request.SrcAccount = $sourceAccountId;
                $request.DstAccount = $destAccountId;
                $request.Amount = $asset.FreeAmount;
                $request.Currency = $asset.Currency;
                $request.Comment = "";
                try{
                    $mm.TransferMoney($request);
                }
                catch{
                    "Error During Transfer Money {$request}"
                }
            }   
        }
        else
        {
            "Source Account is Cash, Dst Acc is Margin - can not transfer";
            return;
        }
    }
}



function DepositWithdrawalMethod{
    param([System.Collections.Generic.List[TickTrader.BusinessObjects.AccountInfo]]$souceAccountInfo,`
            [System.Collections.Generic.List[TickTrader.BusinessObjects.AccountInfo]]$destAccountInfo,`
            [System.Collections.Generic.Dictionary[string,string]]$symbolMapDict,`
            [System.Collections.Generic.List[string]]$currencyToProcessList1);
    
    Start-Sleep -s 1;

    $sourceAccountId = $souceAccountInfo.AccountId;
    $destAccountId = $destAccountInfo.AccountId;
    $srcAccType = $souceAccountInfo.AccountingType.Value;
    $dstAccType = $destAccountInfo.AccountingType.Value
    
    if($srcAccType -ne [TickTrader.BusinessObjects.AccountingTypes]::Cash)
    {
        if($currencyToProcessList1.Count -gt 0 -and $souceAccountInfo.BalanceCurrency -in $currencyToProcessList1 -or $currencyToProcessList1.Count -eq 0)
        {
            try{
                $requestWithdrawal = New-Object TickTrader.BusinessObjects.Requests.DepositWithdrawalRequest;
                $requestWithdrawal.Amount = -$souceAccountInfo.Balance;
                $requestWithdrawal.Currency = $souceAccountInfo.BalanceCurrency;
                $requestWithdrawal.AccountId = $sourceAccountId;
                $report = $mm.DepositWithdrawal($requestWithdrawal);
                "Balance Operation for {$requestWithdrawal.AccountId}: {$requestWithdrawal.Amount} {$requestWithdrawal.Currency} - Success;"
                try{
                    $requestDeposit = New-Object TickTrader.BusinessObjects.Requests.DepositWithdrawalRequest;
                    $requestDeposit.Amount = $souceAccountInfo.Balance;
                    $targetCurrency = $symbolMapDict[$souceAccountInfo.BalanceCurrency];
                    if($null -eq $targetCurrency) 
                    {
                        $targetCurrency = $souceAccountInfo.BalanceCurrency;
                    }
                    $requestDeposit.Currency = $targetCurrency;
                    $requestDeposit.AccountId = $destAccountId;
                    $report = $mm.DepositWithdrawal($requestDeposit);
                    "Balance Operation for {$requestDeposit.AccountId}: {$requestDeposit.Amount} {$requestDeposit.Currency} - Success;"
                }
                catch{
                         "Error During Deposit for {$destAccountId}. Start Rollback Operation";
                         $requestRollback = New-Object TickTrader.BusinessObjects.Requests.DepositWithdrawalRequest;
                         $requestRollback.Amount = $souceAccountInfo.Balance;
                         $requestRollback.Currency = $souceAccountInfo.BalanceCurrency;
                         $requestRollback.AccountId = $sourceAccountId;
                         $requestRollback.TransferMoney = $true;
                         $requestRollback.Comment = "Rollback Operation";
                         $report = $mm.DepositWithdrawal($requestRollback);
                     }
            }
            catch
            {
                 "Error During Withdrawal Operation for {$sourceAccountId}.";
            }
      }
    }
    else
    {
        if($srcAccType -eq [TickTrader.BusinessObjects.AccountingTypes]::Cash -and $dstAccType -eq [TickTrader.BusinessObjects.AccountingTypes]::Cash)
        {
            $assetsToProcess = $souceAccountInfo.Assets;# | Where-Object -Property FreeAmount -gt 0;
            if($currencyToProcessList1.Count -gt 0){
                $assetsToProcess = $assetsToProcess | Where-Object -Property Currency -In $currencyToProcessList1;
                "Only {$assetsToProcess} will be proccessed";
            }
            foreach($asset in $assetsToProcess)
            {
                try{
                     $requestWithdrawal = New-Object TickTrader.BusinessObjects.Requests.DepositWithdrawalRequest;
                     $requestWithdrawal.Amount = -$asset.FreeAmount;
                     $requestWithdrawal.Currency = $asset.Currency;
                     $requestWithdrawal.AccountId = $sourceAccountId;
                     $report = $mm.DepositWithdrawal($requestWithdrawal);
                     "Balance Operation for Account - $($requestWithdrawal.AccountId): Amount - $($requestWithdrawal.Amount) Currency - $($requestWithdrawal.Currency) - Success;"
                     try{
                         $requestDeposit = New-Object TickTrader.BusinessObjects.Requests.DepositWithdrawalRequest;
                         $requestDeposit.Amount = $asset.FreeAmount;
                         $targetCurrency = $symbolMapDict[$asset.Currency];
                         if($null -eq $targetCurrency)
                         {
                             $targetCurrency = $asset.Currency;;
                         }
                         $requestDeposit.Currency = $targetCurrency;
                         $requestDeposit.AccountId = $destAccountId;
                         $report = $mm.DepositWithdrawal($requestDeposit);
                         "Balance Operation for Account - $($requestDeposit.AccountId): Amount - $($requestDeposit.Amount) Currency - $($requestDeposit.Currency) - Success;"
                     }
                     catch{
                         "Error During Deposit for {$destAccountId}. Start Rollback Operation";
                         $requestRollback = New-Object TickTrader.BusinessObjects.Requests.DepositWithdrawalRequest;
                         $requestRollback.Amount = $asset.FreeAmount;
                         $requestRollback.Currency = $asset.Currency;
                         $requestRollback.AccountId = $sourceAccountId;
                         $requestRollback.TransferMoney = $true;
                         $requestRollback.Comment = "Rollback Operation";
                         $report = $mm.DepositWithdrawal($requestRollback);
                     }
                }
                catch{
                    "Error During Withdrawal Operation for {$sourceAccountId}.";
                }
                    
            }   
        }
        else
        {
            "Source Account is Cash, Dst Acc is Margin - can not transfer";
            return;
        }
    }        
}

function TransferMoney{
    param([long]$sourceAccountId, [long]$destAccountId, [string]$symbolMapString, [string]$currenciesToProcessString);

    "Start Transfer Money for $sourceAccountId to $destAccountId";
    if(![System.String]::IsNullOrEmpty($symbolMapString))
    {
        $symbols =  $symbolMapString.Replace(" ", "").Split(",", [System.StringSplitOptions]::RemoveEmptyEntries).Split([System.String[]]("->"), [System.StringSplitOptions]::RemoveEmptyEntries);
    }

    $currencyToProcessList = New-Object System.Collections.Generic.List[string];
    if(![System.String]::IsNullOrEmpty($currenciesToProcessString))
    {
        $currencyToProcessList = $currenciesToProcessString.Replace(" ", "").Split(",;".ToCharArray(), [System.StringSplitOptions]::RemoveEmptyEntries);
    }

    $allCurrencies = $mm.RequestAllCurrencies();
    $allCurrencies = $allCurrencies | Select-Object -ExpandProperty Name;
    $souceAccountInfo1 = $mm.RequestAccountById($sourceAccountId);
    $destAccountInfo1 = $mm.RequestAccountById($destAccountId);

    $symbolMapDict1 = New-Object System.Collections.Generic.Dictionary[string`,string];
    $length = $symbols.Length;
    if($length % 2 -ne 0)
    {
        "Wrong Symbol Map string length. Odd symbols {$length}";
        return;
    }

    for ($i = 0; $i -lt $length - 1 ; $i += 2)
    {
        if($allCurrencies -contains $symbols[$i] -and $allCurrencies -contains $symbols[$i + 1])
        {
            if($souceAccountInfo1.BalanceCurrency -eq $symbols[$i] -or ($souceAccountInfo1.Assets | Select-Object -ExpandProperty Currency) -contains $symbols[$i])
            {
                $symbolMapDict1.Add($symbols[$i], $symbols[$i + 1]);
            }
        }
    }
        
    if($symbolMapDict1.Count -gt 0)
    {
        DepositWithdrawalMethod $souceAccountInfo1 $destAccountInfo1 $symbolMapDict1 $currencyToProcessList;
    }
    else
    {
        TransferMoneyMethod $souceAccountInfo1 $destAccountInfo1 $currencyToProcessList;
    }
}
