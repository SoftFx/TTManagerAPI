Import-Module .\ManagerModelModule.psm1;

<#
    You should set up credentials and module path in config.xml file
    To get more info you can use:
    Get-Help Connect -Detailed
#>

Connect $true

$accountId = 8
$symbol = "EURUSD"

$side1 = ([TickTrader.BusinessObjects.OrderSides]::Buy)
$type1 = ([TickTrader.BusinessObjects.OrderTypes]::Limit)
$amount1 = 100000
$price1 = 1.51
$stopprice1 = 1.52

$side2 = ([TickTrader.BusinessObjects.OrderSides]::Buy)
$type2 = ([TickTrader.BusinessObjects.OrderTypes]::Limit)
$amount2 = 100000
$price2 = 1.51
$stopprice2 = 1.52

$triggerType1 = ([TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]::OnPendingOrderExpired)
$orderId1 = 1000000
$timestamp1 = ([datetime]::new(2021, 12, 1))

$triggerType2 = ([TickTrader.BusinessObjects.ContingentOrders.ContingentOrderTriggerTypes]::OnPendingOrderExpired)
$orderId2 = 1000000
$timestamp2 = ([datetime]::new(2021, 12, 1))

$options = ([TickTrader.BusinessObjects.Requests.TradeRequestOptions]::ClientRequest)

CreateContingentOrderSinlgeOrderSingleTrigger $accountId $symbol $side1 $type1 $amount1 $price1 $stopprice1 $triggerType1 $orderId1 $timestamp1 $options;
CreateContingentOrderSinlgeOrderTwoTriggers $accountId $symbol $side1 $type1 $amount1 $price1 $stopprice1 $triggerType1 $orderId1 $timestamp1 $triggerType2 $orderId2 $timestamp2 $options;
CreateContingentOrderOcoOrdersSingleTrigger $accountId $symbol $side1 $type1 $amount1 $price1 $stopprice1 $side2 $type2 $amount2 $price2 $stopprice2 $triggerType1 $orderId1 $timestamp1 $options;
CreateContingentOrderOcoOrdersTwoTriggers $accountId $symbol $side1 $type1 $amount1 $price1 $stopprice1 $side2 $type2 $amount2 $price2 $stopprice2 $triggerType1 $orderId1 $timestamp1 $triggerType2 $orderId2 $timestamp2 $options;

Disconnect