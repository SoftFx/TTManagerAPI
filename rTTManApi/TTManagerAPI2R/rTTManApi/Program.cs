using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TickTrader.BusinessObjects;
using TickTrader.BusinessObjects.Requests;
using TickTrader.Manager;
using TickTrader.Manager.Contract;
using TickTrader.Manager.Model;

namespace rTTManApi
{
    public class rTTManApiHost
    {
        struct AssetDailySnapshot
        {
            public string Currency;
            public decimal Amount;
            public decimal FreeAmount;
            public decimal LockedAmount;
            public decimal CurrencyToUsdConversionRate;
            public decimal UsdToCurrencyConversionRate;
            public DateTime Timestamp;
            public double AccountId;

            public AssetDailySnapshot(AssetSnapshot asset, DateTime timestamp, double accountId)
            {
                Currency = asset.Currency;
                Amount = asset.Amount;
                FreeAmount = asset.FreeAmount;
                LockedAmount = asset.LockedAmount;
                CurrencyToUsdConversionRate = asset.CurrencyToUsdConversionRate;
                UsdToCurrencyConversionRate = asset.UsdToCurrencyConversionRate;
                Timestamp = timestamp;
                AccountId = accountId;
            }
        }
        #region Private fields

        private static TickTraderManagerModel _manager;
        private static List<GroupInfo> _groupList;
        private static List<AccountInfo> _accountList;
        private static List<Order> _orderList;
        private static List<TradeReport> _tradeReportList;
        private static List<AssetInfo> _assetList;
        private static List<AssetDailySnapshot> _snapshotList;

        #endregion

        #region Connection

        public static int Connect(string address, string login, string password)
        {
            try
            {
                Logger.InitLogger();
                _manager = new TickTraderManagerModel();
                Logger.Log.InfoFormat("Connecting to {0}, login {1}", address, login);
                if (_manager.Connect(address, int.Parse(login), password))
                {
                    Logger.Log.Info("Connected successfully");
                    return 0;
                }
                Logger.Log.Info("Connection failed");
                return -1;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Connection failed because {0}", ex.Message);
                return -2;
            }
        }

        public static int Disconnect()
        {
            try
            {
                Logger.Log.Info("Disconnecting");
                if (_manager.Disconnect())
                {
                    Logger.Log.Info("Disconnected successfully");
                    return 0;
                }
                Logger.Log.Info("Disconnection failed");
                return -1;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Disconnection failed because {0}", ex.Message);
                return -2;
            }
        }

        #endregion
        
        #region Get groups

        public static int GetAllGroups()
        {
            try
            {
                _groupList?.Clear();
                Logger.Log.Info("Requesting all groups");
                _groupList = _manager.RequestAllGroups();
                Logger.Log.InfoFormat("Recieved {0} groups", _groupList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting all groups failed because {0}", ex.Message);
                return -1;
            }
        }

        public static double[] GetId()
        {
            return _groupList.Select(it => (double)it.Id).ToArray();
        }

        public static string[] GetGroupName()
        {
            return _groupList.Select(it => it.Name).ToArray();
        }

        public static string[] GetDomain()
        {
            return _groupList.Select(it => it.Domain).ToArray();
        }

        public static double[] GetMarginalCallLevel()
        {
            return _groupList.Select(it => (double)it.MarginCallLevel).ToArray();
        }

        public static double[] GetStopOutLevel()
        {
            return _groupList.Select(it => (double)it.StopOutLevel).ToArray();
        }

        public static double[] GetMarginLevelType()
        {
            return _groupList.Select(it => (double)it.MarginLevelType).ToArray();
        }

        public static string[] GetRolloverType()
        {
            return _groupList.Select(it => it.RolloverType.ToString()).ToArray();
        }

        public static string[] GetStopOutMode()
        {
            return _groupList.Select(it => it.StopOutMode.ToString()).ToArray();
        }

        public static string[] GetGroupSecurities()
        {
            return _groupList.Select(it => it.GroupSecurities.ToString()).ToArray();
        }

        public static bool[] GetIsWebApiEnabled()
        {
            return _groupList.Select(it => it.IsWebApiEnabled).ToArray();
        }

        public static string[] GetSecurities()
        {
            var groupNames = GetGroupName();
            var securities = _manager.RequestAllGroupSecurities();
            var result =
                groupNames.Select(
                    @group =>
                        securities.Where(security => @group.Equals(security.Group))
                            .Aggregate("", (current, security) => string.Concat(current, " ", security.Security)))
                    .ToArray();
            return result;
        }

        #endregion

        #region Get accounts

        public static int GetAllAccounts()
        {
            try
            {
                _accountList?.Clear();
                Logger.Log.Info("Requesting all accounts");
                _accountList = _manager.RequestAllAccounts();
                Logger.Log.InfoFormat("Recieved {0} accounts", _accountList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting all accounts failed because {0}", ex.Message);
                return -1;
            }
        }

        public static double[] GetAccountId()
        {
            return _accountList.Select(it => (double)it.AccountId).ToArray();
        }

        public static string[] GetAccountName()
        {
            return _accountList.Select(it => it.Name).ToArray();
        }

        public static string[] GetAccountDomain()
        {
            return _accountList.Select(it => it.Domain).ToArray();
        }

        public static string[] GetAccountGroup()
        {
            return _accountList.Select(it => it.Group).ToArray();
        }

        public static string[] GetAccountingType()
        {
            return _accountList.Select(it => it.AccountingType.ToString()).ToArray();
        }

        public static bool[] GetBlocked()
        {
            return _accountList.Select(it => it.Blocked).ToArray();
        }

        public static bool[] GetReadonly()
        {
            return _accountList.Select(it => it.Readonly).ToArray();
        }

        public static double[] GetLeveage()
        {
            return _accountList.Select(it => (double)it.Leverage).ToArray();
        }

        public static double[] GetProfit()
        {
            return _accountList.Select(it => (double)it.Profit).ToArray();
        }

        public static double[] GetComission()
        {
            return _accountList.Select(it => (double)it.Commission).ToArray();
        }

        public static double[] GetAgentComission()
        {
            return _accountList.Select(it => (double)it.AgentCommission).ToArray();
        }

        public static double[] GetSwap()
        {
            return _accountList.Select(it => (double)it.Swap).ToArray();
        }

        public static double[] GetEquity()
        {
            return _accountList.Select(it => (double)it.Equity).ToArray();
        }

        public static double[] GetMargin()
        {
            return _accountList.Select(it => (double)it.Margin).ToArray();
        }

        public static double[] GetMarginLevel()
        {
            return _accountList.Select(it => (double)it.MarginLevel).ToArray();
        }

        public static double[] GetBalance()
        {
            return _accountList.Select(it => (double)it.Balance).ToArray();
        }

        public static string[] GetBalanceCurrency()
        {
            return _accountList.Select(it => it.BalanceCurrency).ToArray();
        }

        public static double[] GetMarginCallLevel()
        {
            return _accountList.Select(it => (double)it.MarginCallLevel).ToArray();
        }

        public static double[] GetAccountStopOutLevel()
        {
            return _accountList.Select(it => (double)it.StopOutLevel).ToArray();
        }

        public static bool[] GetIsValid()
        {
            return _accountList.Select(it => it.IsValid).ToArray();
        }

        public static bool[] GetAccountIsWebApiEnabled()
        {
            return _accountList.Select(it => it.IsWebApiEnabled).ToArray();
        }

        public static bool[] GetIsTwoFactorAuthSet()
        {
            return _accountList.Select(it => it.IsTwoFactorAuthSet).ToArray();
        }

        public static bool[] GetIsArchived()
        {
            return _accountList.Select(it => it.IsArchived).ToArray();
        }

        public static string[] GetFeedPriority()
        {
            return _accountList.Select(it => it.FeedPriority.ToString()).ToArray();
        }

        public static double[] GetVersion()
        {
            return _accountList.Select(it => (double)it.Version).ToArray();
        }

        public static double[] GetMarginFree()
        {
            return _accountList.Select(it => (double)it.MarginFree).ToArray();
        }

        public static double[] GetTotalComission()
        {
            return _accountList.Select(it => (double)it.TotalCommission).ToArray();
        }

        #endregion

        #region Get orders

        public static int GetAllOrders()
        {
            try
            {
                _orderList?.Clear();
                Logger.Log.Info("Requesting all orders");
                _orderList = _manager.RequestAllOrders();
                Logger.Log.InfoFormat("Recieved {0} orders", _orderList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting all orders failed because {0}", ex.Message);
                return -1;
            }
        }

        public static int GetOrders(double accId)
        {
            try
            {
                _orderList?.Clear();
                Logger.Log.InfoFormat("Requesting all orders of account {0}", accId);
                _orderList = _manager.RequestOrdersByAccountId(Convert.ToInt64(accId));
                Logger.Log.InfoFormat("Recieved {0} orders", _orderList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting all orders of account {0} failed because {1}", accId, ex.Message);
                return -1;
            }
        }

        public static double[] GetOrderRangeId()
        {
            return _orderList.Select(it => (double)it.RangeId).ToArray();
        }

        public static double[] GetOrderAccountId()
        {
            return _orderList.Select(it => (double)it.AccountId).ToArray();
        }

        public static string[] GetOrderSymbol()
        {
            return _orderList.Select(it => it.Symbol).ToArray();
        }

        public static string[] GetOrderSymbolAlias()
        {
            return _orderList.Select(it => it.SymbolAlias).ToArray();
        }

        public static string[] GetOrderSymbolAliasOrName()
        {
            return _orderList.Select(it => it.SymbolAliasOrName).ToArray();
        }

        public static double[] GetOrderOrderId()
        {
            return _orderList.Select(it => (double)it.OrderId).ToArray();
        }

        public static string[] GetOrderClientOrderId()
        {
            return _orderList.Select(it => it.ClientOrderId).ToArray();
        }

        public static double[] GetOrderParentOrderId()
        {
            return _orderList.Select(it => (double)(it.ParentOrderId ?? 0)).ToArray();
        }

        public static double[] GetOrderPrice()
        {
            return _orderList.Select(it => (double)(it.Price ?? 0)).ToArray();
        }

        public static double[] GetOrderStopPrice()
        {
            return _orderList.Select(it => (double)(it.StopPrice ?? 0)).ToArray();
        }

        public static string[] GetOrderSide()
        {
            return _orderList.Select(it => it.Side.ToString()).ToArray();
        }

        public static string[] GetOrderType()
        {
            return _orderList.Select(it => it.Type.ToString()).ToArray();
        }

        public static string[] GetOrderInitialType()
        {
            return _orderList.Select(it => it.InitialType.ToString()).ToArray();
        }

        public static string[] GetOrderStatus()
        {
            return _orderList.Select(it => it.Status.ToString()).ToArray();
        }

        public static double[] GetOrderAmount()
        {
            return _orderList.Select(it => (double)it.Amount).ToArray();
        }

        public static double[] GetOrderRemainingAmount()
        {
            return _orderList.Select(it => (double)it.RemainingAmount).ToArray();
        }

        public static double[] GetOrderAggrFillPrice()
        {
            return _orderList.Select(it => (double)it.AggrFillPrice).ToArray();
        }

        public static double[] GetOrderAverageFillPrice()
        {
            return _orderList.Select(it => (double)it.AverageFillPrice).ToArray();
        }

        public static DateTime[] GetOrderCreated()
        {
            return _orderList.Select(it => new DateTime(it.Created.Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static DateTime[] GetOrderModified()
        {
            return _orderList.Select(it => new DateTime((it.Modified ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static DateTime[] GetOrderFilled()
        {
            return _orderList.Select(it => new DateTime((it.Filled ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static DateTime[] GetOrderPositionCreated()
        {
            return _orderList.Select(it => new DateTime((it.PositionCreated ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static double[] GetOrderStopLoss()
        {
            return _orderList.Select(it => (double)(it.StopLoss ?? 0)).ToArray();
        }

        public static double[] GetOrderTakeProfit()
        {
            return _orderList.Select(it => (double)(it.TakeProfit ?? 0)).ToArray();
        }

        public static double[] GetOrderProfit()
        {
            return _orderList.Select(it => (double)(it.Profit ?? 0)).ToArray();
        }

        public static double[] GetOrderMargin()
        {
            return _orderList.Select(it => (double)(it.Margin ?? 0)).ToArray();
        }

        public static string[] GetOrderUserComment()
        {
            return _orderList.Select(it => it.UserComment).ToArray();
        }

        public static string[] GetOrderManagerComment()
        {
            return _orderList.Select(it => it.ManagerComment).ToArray();
        }

        public static string[] GetOrderUserTag()
        {
            return _orderList.Select(it => it.UserTag).ToArray();
        }

        public static string[] GetOrderManagerTag()
        {
            return _orderList.Select(it => it.ManagerTag).ToArray();
        }

        public static double[] GetOrderMagic()
        {
            return _orderList.Select(it => (double)it.Magic).ToArray();
        }

        public static double[] GetOrderCommission()
        {
            return _orderList.Select(it => (double)(it.Commission ?? 0)).ToArray();
        }

        public static double[] GetOrderAgentCommision()
        {
            return _orderList.Select(it => (double)(it.AgentCommision ?? 0)).ToArray();
        }

        public static double[] GetOrderSwap()
        {
            return _orderList.Select(it => (double)(it.Swap ?? 0)).ToArray();
        }

        public static DateTime[] GetOrderExpired()
        {
            return _orderList.Select(it => new DateTime((it.Expired ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static double[] GetOrderClosePrice()
        {
            return _orderList.Select(it => (double)(it.ClosePrice ?? 0)).ToArray();
        }

        public static double[] GetOrderMarginRateInitial()
        {
            return _orderList.Select(it => (double)(it.MarginRateInitial ?? 0)).ToArray();
        }

        public static double[] GetOrderMarginRateCurrent()
        {
            return _orderList.Select(it => (double)(it.MarginRateCurrent ?? 0)).ToArray();
        }

        public static double[] GetOrderOpenConversionRate()
        {
            return _orderList.Select(it => (double)(it.OpenConversionRate ?? 0)).ToArray();
        }

        public static double[] GetOrderCloseConversionRate()
        {
            return _orderList.Select(it => (double)(it.OpenConversionRate ?? 0)).ToArray();
        }

        public static double[] GetOrderVersion()
        {
            return _orderList.Select(it => (double)it.Version).ToArray();
        }

        public static string[] GetOrderOptions()
        {
            return _orderList.Select(it => it.Options.ToString()).ToArray();
        }

        public static double[] GetOrderTaxes()
        {
            return _orderList.Select(it => (double)(it.Taxes ?? 0)).ToArray();
        }

        public static double[] GetOrderReqOpenPrice()
        {
            return _orderList.Select(it => (double)(it.ReqOpenPrice ?? 0)).ToArray();
        }

        public static double[] GetOrderReqOpenAmount()
        {
            return _orderList.Select(it => (double)(it.ReqOpenAmount ?? 0)).ToArray();
        }

        public static string[] GetOrderClientApp()
        {
            return _orderList.Select(it => it.ClientApp).ToArray();
        }

        public static bool[] GetOrderIsReducedOpenCommission()
        {
            return _orderList.Select(it => it.IsReducedOpenCommission).ToArray();
        }

        public static bool[] GetOrderIsReducedCloseCommission()
        {
            return _orderList.Select(it => it.IsReducedCloseCommission).ToArray();
        }

        public static double[] GetOrderMaxVisibleAmount()
        {
            return _orderList.Select(it => (double)(it.MaxVisibleAmount ?? 0)).ToArray();
        }

        public static double[] GetOrderFilledAmount()
        {
            return _orderList.Select(it => (double)it.FilledAmount).ToArray();
        }

        public static double[] GetOrderVisibleAmount()
        {
            return _orderList.Select(it => (double)it.VisibleAmount).ToArray();
        }

        public static double[] GetOrderTotalCommission()
        {
            return _orderList.Select(it => (double)it.TotalCommission).ToArray();
        }

        public static string[] GetOrderActivation()
        {
            return _orderList.Select(it => it.Activation.ToString()).ToArray();
        }

        public static bool[] GetOrderIsPending()
        {
            return _orderList.Select(it => it.IsPending).ToArray();
        }

        #endregion

        #region Get trade history

        public static int GetTradeReports(double accId, DateTime from, DateTime to, bool skipCancelled)
        {
            try
            {
                _tradeReportList?.Clear();
                var req = new TradeHistoryOverallRequest
                {
                    Accounts = new List<long> { Convert.ToInt64(accId) },
                    FromDate = from,
                    ToDate = to,
                    IsUTC = true,
                    SkipCancelOrder = skipCancelled
                };
                Logger.Log.InfoFormat("Requesting trade history of {0} from {1} to {2}", accId, from, to);
                var tradeHistory = _manager.QueryTradeHistoryOverall(req);
                _tradeReportList = tradeHistory.Reports;
                while (!tradeHistory.IsEndOfStream)
                {
                    req.Streaming = new StreamingInfo<string> { PosId = tradeHistory.LastId };
                    tradeHistory = _manager.QueryTradeHistoryOverall(req);
                    _tradeReportList.AddRange(tradeHistory.Reports);
                }
                Logger.Log.InfoFormat("Recieved {0} trade reports", _tradeReportList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting trade history failed because {0}", ex.Message);
                _tradeReportList?.Clear();
                return -1;
            }
        }

        public static int GetTradeReports(double[] accId, DateTime from, DateTime to, bool skipCancelled)
        {
            try
            {
                _tradeReportList?.Clear();
                var req = new TradeHistoryOverallRequest
                {
                    Accounts = accId.Select(Convert.ToInt64).ToList(),
                    FromDate = from,
                    ToDate = to,
                    IsUTC = true,
                    SkipCancelOrder = skipCancelled
                };
                var accList = accId[0].ToString();
                for (var i = 1; i < accId.Length; i++)
                {
                    accList = string.Concat(accList, ", ", accId[i].ToString());
                }
                Logger.Log.InfoFormat("Requesting trade history of {0} from {1} to {2}", accList, from, to);
                var tradeHistory = _manager.QueryTradeHistoryOverall(req);
                _tradeReportList = tradeHistory.Reports;
                while (!tradeHistory.IsEndOfStream)
                {
                    req.Streaming = new StreamingInfo<string> { PosId = tradeHistory.LastId };
                    tradeHistory = _manager.QueryTradeHistoryOverall(req);
                    _tradeReportList.AddRange(tradeHistory.Reports);
                }
                Logger.Log.InfoFormat("Recieved {0} trade reports", _tradeReportList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting trade history failed because {0}", ex.Message);
                _tradeReportList?.Clear();
                return -1;
            }
        }

        public static double[] GetTradeAccountId()
        {
            return _tradeReportList.Select(it => (double)it.AccountId).ToArray();
        }

        public static string[] GetTradeId()
        {
            return _tradeReportList.Select(it => it.Id).ToArray();
        }

        public static string[] GetTradeDomain()
        {
            return _tradeReportList.Select(it => it.Domain).ToArray();
        }

        public static string[] GetTradeGroup()
        {
            return _tradeReportList.Select(it => it.Group).ToArray();
        }

        public static double[] GetTradeOrderId()
        {
            return _tradeReportList.Select(it => (double)it.OrderId).ToArray();
        }

        public static double[] GetTradeOrderActionNo()
        {
            return _tradeReportList.Select(it => (double)it.OrderActionNo).ToArray();
        }

        public static string[] GetTradeClientOrderId()
        {
            return _tradeReportList.Select(it => it.ClientOrderId).ToArray();
        }

        public static string[] GetTradeTrType()
        {
            return _tradeReportList.Select(it => it.TrType.ToString()).ToArray();
        }

        public static string[] GetTradeTrReason()
        {
            return _tradeReportList.Select(it => it.TrReason.ToString()).ToArray();
        }

        public static DateTime[] GetTradeTrTime()
        {
            return _tradeReportList.Select(it => new DateTime(it.TrTime.Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static string[] GetTradeSide()
        {
            return _tradeReportList.Select(it => it.Side.ToString()).ToArray();
        }

        public static string[] GetTradeOrderType()
        {
            return _tradeReportList.Select(it => it.OrderType.ToString()).ToArray();
        }

        public static string[] GetTradeParentOrderType()
        {
            return _tradeReportList.Select(it => it.ParentOrderType.ToString()).ToArray();
        }

        public static DateTime[] GetTradeOrderCreated()
        {
            return _tradeReportList.Select(it => new DateTime((it.OrderCreated ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static DateTime[] GetTradeOrderModified()
        {
            return _tradeReportList.Select(it => new DateTime((it.OrderModified ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static string[] GetTradeSymbol()
        {
            return _tradeReportList.Select(it => it.Symbol).ToArray();
        }

        public static string[] GetTradeSymbolAlias()
        {
            return _tradeReportList.Select(it => it.SymbolAlias).ToArray();
        }

        public static string[] GetTradeSymbolAliasOrName()
        {
            return _tradeReportList.Select(it => it.SymbolAliasOrName).ToArray();
        }

        public static double[] GetTradeSymbolFk()
        {
            return _tradeReportList.Select(it => (double)(it.SymbolFk ?? 0)).ToArray();
        }

        public static double[] GetTradeOrderAmount()
        {
            return _tradeReportList.Select(it => (double)(it.OrderAmount ?? 0)).ToArray();
        }

        public static double[] GetTradeOrderRemainingAmount()
        {
            return _tradeReportList.Select(it => (double)(it.OrderRemainingAmount ?? 0)).ToArray();
        }

        public static double[] GetTradeOrderHiddenAmount()
        {
            return _tradeReportList.Select(it => (double)(it.OrderHiddenAmount ?? 0)).ToArray();
        }

        public static double[] GetTradeOrderLastFillAmount()
        {
            return _tradeReportList.Select(it => (double)(it.OrderLastFillAmount ?? 0)).ToArray();
        }

        public static double[] GetTradeOrderPrice()
        {
            return _tradeReportList.Select(it => (double)(it.OrderPrice ?? 0)).ToArray();
        }

        public static double[] GetTradeOrderStopPrice()
        {
            return _tradeReportList.Select(it => (double)(it.OrderStopPrice ?? 0)).ToArray();
        }

        public static double[] GetTradeOrderFillPrice()
        {
            return _tradeReportList.Select(it => (double)(it.OrderFillPrice ?? 0)).ToArray();
        }

        public static double[] GetTradeReqOpenPrice()
        {
            return _tradeReportList.Select(it => (double)(it.ReqOpenPrice ?? 0)).ToArray();
        }

        public static double[] GetTradeReqOpenAmount()
        {
            return _tradeReportList.Select(it => (double)(it.ReqOpenAmount ?? 0)).ToArray();
        }

        public static double[] GetTradeReqClosePrice()
        {
            return _tradeReportList.Select(it => (double)(it.ReqClosePrice ?? 0)).ToArray();
        }

        public static double[] GetTradeReqCloseAmount()
        {
            return _tradeReportList.Select(it => (double)(it.ReqCloseAmount ?? 0)).ToArray();
        }

        public static string[] GetTradeClientApp()
        {
            return _tradeReportList.Select(it => it.ClientApp).ToArray();
        }

        public static DateTime[] GetTradeRequestTime()
        {
            return _tradeReportList.Select(it => new DateTime((it.RequestTime ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static double[] GetTradePosId()
        {
            return _tradeReportList.Select(it => (double)(it.PosId ?? 0)).ToArray();
        }

        public static double[] GetTradePosById()
        {
            return _tradeReportList.Select(it => (double)(it.PosById ?? 0)).ToArray();
        }

        public static double[] GetTradePosAmount()
        {
            return _tradeReportList.Select(it => (double)(it.PosAmount ?? 0)).ToArray();
        }

        public static double[] GetTradePosRemainingAmount()
        {
            return _tradeReportList.Select(it => (double)(it.PosRemainingAmount ?? 0)).ToArray();
        }

        public static string[] GetTradePosRemainingSide()
        {
            return _tradeReportList.Select(it => it.PosRemainingSide.ToString()).ToArray();
        }

        public static double[] GetTradePosRemainingPrice()
        {
            return _tradeReportList.Select(it => (double)(it.PosRemainingPrice ?? 0)).ToArray();
        }

        public static double[] GetTradePosLastAmount()
        {
            return _tradeReportList.Select(it => (double)(it.PosLastAmount ?? 0)).ToArray();
        }

        public static double[] GetTradePosOpenPrice()
        {
            return _tradeReportList.Select(it => (double)(it.PosOpenPrice ?? 0)).ToArray();
        }

        public static DateTime[] GetTradePosOpened()
        {
            return _tradeReportList.Select(it => new DateTime((it.PosOpened ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static double[] GetTradePosClosePrice()
        {
            return _tradeReportList.Select(it => (double)(it.PosClosePrice ?? 0)).ToArray();
        }

        public static DateTime[] GetTradePosClosed()
        {
            return _tradeReportList.Select(it => new DateTime((it.PosClosed ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static double[] GetTradeCommission()
        {
            return _tradeReportList.Select(it => (double)(it.Commission ?? 0)).ToArray();
        }

        public static double[] GetTradeAgentCommission()
        {
            return _tradeReportList.Select(it => (double)(it.AgentCommission ?? 0)).ToArray();
        }

        public static double[] GetTradeSwap()
        {
            return _tradeReportList.Select(it => (double)(it.Swap ?? 0)).ToArray();
        }

        public static double[] GetTradeProfitLoss()
        {
            return _tradeReportList.Select(it => (double)(it.ProfitLoss ?? 0)).ToArray();
        }

        public static double[] GetTradeBalance()
        {
            return _tradeReportList.Select(it => (double)(it.Balance ?? 0)).ToArray();
        }

        public static double[] GetTradeBalanceMovement()
        {
            return _tradeReportList.Select(it => (double)(it.BalanceMovement ?? 0)).ToArray();
        }

        public static string[] GetTradeBalanceCurrency()
        {
            return _tradeReportList.Select(it => it.BalanceCurrency).ToArray();
        }

        public static string[] GetTradePlatformComment()
        {
            return _tradeReportList.Select(it => it.PlatformComment).ToArray();
        }

        public static string[] GetTradeUserComment()
        {
            return _tradeReportList.Select(it => it.UserComment).ToArray();
        }

        public static string[] GetTradeManagerComment()
        {
            return _tradeReportList.Select(it => it.ManagerComment).ToArray();
        }

        public static string[] GetTradeUserTag()
        {
            return _tradeReportList.Select(it => it.UserTag).ToArray();
        }

        public static string[] GetTradeManagerTag()
        {
            return _tradeReportList.Select(it => it.ManagerTag).ToArray();
        }

        public static double[] GetTradeMagic()
        {
            return _tradeReportList.Select(it => (double)it.Magic).ToArray();
        }

        public static double[] GetTradeMarginRateInitial()
        {
            return _tradeReportList.Select(it => (double)(it.MarginRateInitial ?? 0)).ToArray();
        }

        public static double[] GetTradeStopLoss()
        {
            return _tradeReportList.Select(it => (double)(it.StopLoss ?? 0)).ToArray();
        }

        public static double[] GetTradeTakeProfit()
        {
            return _tradeReportList.Select(it => (double)(it.TakeProfit ?? 0)).ToArray();
        }

        public static double[] GetTradeOpenConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.OpenConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeCloseConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.CloseConversionRate ?? 0)).ToArray();
        }

        public static DateTime[] GetTradeExpired()
        {
            return _tradeReportList.Select(it => new DateTime((it.Expired ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static DateTime[] GetTradePosModified()
        {
            return _tradeReportList.Select(it => new DateTime((it.PosModified ?? DateTime.MinValue).Ticks,DateTimeKind.Utc)).ToArray();
        }

        public static double[] GetTradeProfitToUsdConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.ProfitToUsdConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeUsdToProfitConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.UsdToProfitConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeBalanceToUsdConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.BalanceToUsdConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeUsdToBalanceConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.UsdToBalanceConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeMarginCurrencyToUsdConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.MarginCurrencyToUsdConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeUsdToMarginCurrencyConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.UsdToMarginCurrencyConversionRate ?? 0)).ToArray();
        }

        public static string[] GetTradeMarginCurrency()
        {
            return _tradeReportList.Select(it => it.MarginCurrency).ToArray();
        }

        public static double[] GetTradeProfitCurrencyToUsdConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.ProfitCurrencyToUsdConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeUsdToProfitCurrencyConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.UsdToProfitCurrencyConversionRate ?? 0)).ToArray();
        }

        public static string[] GetTradeProfitCurrency()
        {
            return _tradeReportList.Select(it => it.ProfitCurrency).ToArray();
        }

        public static double[] GetTradeSrcAssetToUsdConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.SrcAssetToUsdConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeUsdToSrcAssetConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.UsdToSrcAssetConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeDstAssetToUsdConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.DstAssetToUsdConversionRate ?? 0)).ToArray();
        }

        public static double[] GetTradeUsdToDstAssetConversionRate()
        {
            return _tradeReportList.Select(it => (double)(it.UsdToDstAssetConversionRate ?? 0)).ToArray();
        }

        public static string[] GetTradeSrcAssetCurrency()
        {
            return _tradeReportList.Select(it => it.SrcAssetCurrency).ToArray();
        }

        public static double[] GetTradeSrcAssetAmount()
        {
            return _tradeReportList.Select(it => (double)(it.SrcAssetAmount ?? 0)).ToArray();
        }

        public static double[] GetTradeSrcAssetMovement()
        {
            return _tradeReportList.Select(it => (double)(it.SrcAssetMovement ?? 0)).ToArray();
        }

        public static string[] GetTradeDstAssetCurrency()
        {
            return _tradeReportList.Select(it => it.DstAssetCurrency).ToArray();
        }

        public static double[] GetTradeDstAssetAmount()
        {
            return _tradeReportList.Select(it => (double)(it.DstAssetAmount ?? 0)).ToArray();
        }

        public static double[] GetTradeDstAssetMovement()
        {
            return _tradeReportList.Select(it => (double)(it.DstAssetMovement ?? 0)).ToArray();
        }

        public static string[] GetTradeOptions()
        {
            return _tradeReportList.Select(it => it.Options.ToString()).ToArray();
        }

        public static double[] GetTradeOrderMaxVisibleAmount()
        {
            return _tradeReportList.Select(it => (double)(it.OrderMaxVisibleAmount ?? 0)).ToArray();
        }

        public static bool[] GetTradeReducedOpenCommissionFlag()
        {
            return _tradeReportList.Select(it => it.ReducedOpenCommissionFlag ?? false).ToArray();
        }

        public static bool[] GetTradeReducedCloseCommissionFlag()
        {
            return _tradeReportList.Select(it => it.ReducedCloseCommissionFlag ?? false).ToArray();
        }

        public static double[] GetTradeSymbolPrecision()
        {
            return _tradeReportList.Select(it => (double)(it.SymbolPrecision ?? 0)).ToArray();
        }

        #endregion

        #region Get assets

        public static int GetAssets(double accId)
        {
            try
            {
                _assetList?.Clear();
                Logger.Log.InfoFormat("Requesting all assets of {0}", accId);
                var account = _manager.RequestAccountById(Convert.ToInt64(accId));
                _assetList = account.Assets;
                Logger.Log.InfoFormat("Recieved {0} assets", _assetList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting all assets failed because {0}", ex.Message);
                return -1;
            }
        }

        public static string[] GetAssetCurrency()
        {
            return _assetList.Select(it => it.Currency).ToArray();
        }

        public static double[] GetAssetCurrencyId()
        {
            return _assetList.Select(it => (double)it.CurrencyId).ToArray();
        }

        public static double[] GetAssetAmount()
        {
            return _assetList.Select(it => (double)it.Amount).ToArray();
        }

        public static double[] GetAssetFreeAmount()
        {
            return _assetList.Select(it => (double)it.FreeAmount).ToArray();
        }

        public static double[] GetAssetLockedAmount()
        {
            return _assetList.Select(it => (double)it.LockedAmount).ToArray();
        }

        #endregion

        #region Get asset snapshots

        public static int GetAssetSnapshots(double accId, DateTime from, DateTime to)
        {
            _snapshotList?.Clear();
            try
            {
                var req = new DailyAccountsSnapshotRequest
                {
                    AccountIds = new List<long> {Convert.ToInt64(accId) },
                    fromDate = from,
                    toDate = to,
                    IsUTC = true,
                };
                _snapshotList = new List<AssetDailySnapshot>();
                Logger.Log.InfoFormat("Requesting asset snapshots of {0} from {1} to {2}", accId, from, to);
                var query = _manager.QueryDailyAccountsSnapshot(req);
                foreach (
                    var ads in
                        query.Reports.SelectMany(
                                snapshot =>
                                    snapshot.Assets.Select(
                                        asset => new AssetDailySnapshot(asset, snapshot.Timestamp, snapshot.AccountId))))
                {
                    _snapshotList.Add(ads);
                }
                while (!query.IsEndOfStream)
                {
                    req.Streaming = new StreamingInfo<string> { PosId = query.LastReportId };
                    query = _manager.QueryDailyAccountsSnapshot(req);
                    foreach (
                        var ads in
                            query.Reports.SelectMany(
                                    snapshot =>
                                        snapshot.Assets.Select(
                                            asset => new AssetDailySnapshot(asset, snapshot.Timestamp, snapshot.AccountId))))
                    {
                        _snapshotList.Add(ads);
                    }
                }
                Logger.Log.InfoFormat("Recieved {0} asset snapshots", _snapshotList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting asset snapshots failed because {0}", ex.Message);
                return -1;
            }
        }

        public static int GetAssetSnapshots(double[] accId, DateTime from, DateTime to)
        {
            try
            {
                var req = new DailyAccountsSnapshotRequest
                {
                    AccountIds = accId.Select(Convert.ToInt64).ToList(),
                    fromDate = from,
                    toDate = to,
                    IsUTC = true,
                };
                _snapshotList = new List<AssetDailySnapshot>();
                var accList = accId[0].ToString();
                for (var i = 1; i < accId.Length; i++)
                {
                    accList = string.Concat(accList, ", ", accId[i].ToString());
                }
                Logger.Log.InfoFormat("Requesting asset snapshots of {0} from {1} to {2}", accList, from, to);
                var query = _manager.QueryDailyAccountsSnapshot(req);
                foreach (
                    var ads in
                        query.Reports.SelectMany(
                                snapshot =>
                                    snapshot.Assets.Select(
                                        asset => new AssetDailySnapshot(asset, snapshot.Timestamp, snapshot.AccountId))))
                {
                    _snapshotList.Add(ads);
                }
                while (!query.IsEndOfStream)
                {
                    req.Streaming = new StreamingInfo<string> { PosId = query.LastReportId };
                    query = _manager.QueryDailyAccountsSnapshot(req);
                    foreach (
                        var ads in
                            query.Reports.SelectMany(
                                    snapshot =>
                                        snapshot.Assets.Select(
                                            asset => new AssetDailySnapshot(asset, snapshot.Timestamp, snapshot.AccountId))))
                    {
                        _snapshotList.Add(ads);
                    }
                }
                Logger.Log.InfoFormat("Recieved {0} asset snapshots", _snapshotList.Count);
                return 0;
            }
            catch (Exception ex)
            {
                Logger.Log.ErrorFormat("Requesting asset snapshots failed because {0}", ex.Message);
                return -1;
            }
        }

        public static double[] GetSnapshotAccountId()
        {
            return _snapshotList.Select(it => it.AccountId).ToArray();
        }

        public static string[] GetSnapshotCurrency()
        {
            return _snapshotList.Select(it => it.Currency).ToArray();
        }

        public static double[] GetSnapshotAmount()
        {
            return _snapshotList.Select(it => (double)it.Amount).ToArray();
        }

        public static double[] GetSnapshotFreeAmount()
        {
            return _snapshotList.Select(it => (double)it.FreeAmount).ToArray();
        }

        public static double[] GetSnapshotLockedAmount()
        {
            return _snapshotList.Select(it => (double)it.LockedAmount).ToArray();
        }

        public static double[] GetSnapshotCurrencyToUsdConversionRate()
        {
            return _snapshotList.Select(it => (double)it.CurrencyToUsdConversionRate).ToArray();
        }

        public static double[] GetSnapshotUsdToCurrencyConversionRate()
        {
            return _snapshotList.Select(it => (double)it.UsdToCurrencyConversionRate).ToArray();
        }

        public static DateTime[] GetSnapshotTimestamp()
        {
            return _snapshotList.Select(it => it.Timestamp).ToArray();
        }

        #endregion

        static void Main(string[] args)
        {
            
        }
    }
}