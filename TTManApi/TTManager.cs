using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using TickTrader.BusinessObjects;
using TickTrader.BusinessObjects.EventArguments;
using TickTrader.BusinessObjects.Requests;
using TickTrader.Common.Business;
using TickTrader.Manager.Model;

namespace TTManApi
{
    public class TTManager : IDisposable
    {
        private readonly ITickTraderManagerModel _manager;
        private Random rnd = new Random();
        private readonly string _address;
        private readonly long _login;
        private readonly string _password;
        public bool isMarginCalled;
        public ITickTraderManagerModel DirectQuery { get => _manager; }

        public TTManager(string server, long login, string password, bool enablePumping = true)
        {
            isMarginCalled = false;
            //var settings = ConfigReader.GetConfig(typeof(BaseTest).Assembly.GetPath());

            _manager = new TickTraderManagerModel();
            _manager.ModelStateChanged += ModelStateChanged;

            _manager.Connect(server, login, password);

            if (enablePumping)
            {
                EnablePumping();
            }
        }

        private void ModelStateChanged(object sender, ConnectionStatusEventArgs args)
        {
            Console.WriteLine($"\n{args.Module} {args.Status}");
        }


        public void Disconnect()
        {
            if (!CheckManagerIsConnected()) return;

            DisablePumping();

            _manager.ModelStateChanged -= ModelStateChanged;
        }

        public void EnablePumping()
        {
            // Bind pumping events.
            _manager.PumpingUpdateAccount += ModelPumpingUpdateAccount;
            _manager.PumpingUpdateOrder += ModelPumpingUpdateOrder;
            //_manager.PumpingUpdateSymbolTick += ModelPumpingUpdateSymbolTick;
            _manager.PumpingUpdatePosition += ModelPumpingUpdatePosition;
            _manager.PumpingUpdateCurrency += ModelPumpingUpdateCurrency;
            _manager.PumpingUpdateSymbolConfig += ModelPumpingUpdateSymbol;
            _manager.PumpingUpdateSymbolSecurity += ModelPumpingUpdateSymbolSecurity;
            _manager.PumpingUpdateDomain += ModelPumpingUpdateDomain;
            _manager.PumpingUpdateGroup += ModelPumpingUpdateGroup;
            _manager.PumpingUpdateGroupSecurity += ModelPumpingUpdateGroupSecurity;
            _manager.PumpingUpdateSplit += ModelPumpingUpdateSplit;
            _manager.PumpingUpdateCurrencyType += ModelPumpingUpdateCurrencyType;

            _manager.EnablePumping();
            _manager.WaitForPumping(60000);
        }

        public void DisablePumping()
        {
            _manager.PumpingUpdateAccount -= ModelPumpingUpdateAccount;
            _manager.PumpingUpdateOrder -= ModelPumpingUpdateOrder;
            _manager.PumpingUpdateSymbolSecurity -= ModelPumpingUpdateSymbolSecurity;
            _manager.PumpingUpdateDomain -= ModelPumpingUpdateDomain;
            _manager.PumpingUpdateGroup -= ModelPumpingUpdateGroup;
            _manager.PumpingUpdateGroupSecurity -= ModelPumpingUpdateGroupSecurity;
            _manager.PumpingUpdateSplit -= ModelPumpingUpdateSplit;
            _manager.PumpingUpdateCurrency -= ModelPumpingUpdateCurrency;
            _manager.PumpingUpdateSymbolConfig -= ModelPumpingUpdateSymbol;
            _manager.PumpingUpdatePosition -= ModelPumpingUpdatePosition;
            _manager.PumpingUpdateCurrencyType -= ModelPumpingUpdateCurrencyType;

            _manager.DisablePumping();
            _manager.Disconnect();
        }

        private long waitingAccountId;
        private PumpingTransactionType waitingAccountTransactionType;
        private EventWaitHandle accountWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);

        private void ModelPumpingUpdateAccount(object sender, PumpingUpdateAccountEventArgs e)
        {
            if ((e.Account.AccountId == waitingAccountId || waitingAccountId == 0) && e.TransactionType == waitingAccountTransactionType)
                accountWaitHandle.Set();
        }

        public void WaitForAccountUpdate(Action action, long accountId = 0, PumpingTransactionType pumpingTransactionType = PumpingTransactionType.TRANS_UPDATE, int timeout = 1000)
        {
            waitingAccountTransactionType = pumpingTransactionType;
            waitingAccountId = accountId;

            action.Invoke();

            if (!accountWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public AccountInfo CreateAccount(AccountNewRequest accountNewRequest)
        {
            AccountInfo account = null;
            WaitForAccountUpdate(() => { account = _manager.CreateAccount(accountNewRequest); }, 0, PumpingTransactionType.TRANS_ADD);
            return account;
        }

        public AccountInfo CreateAccount(AccountingTypes accountingType, decimal balance, string balanceCurrency,
                                         bool? isTokenCommissionEnabled, int leverage, string group, bool mustChangePassword = false)
        {
            AccountNewRequest newRequest = new AccountNewRequest()
            {
                AccountingType = accountingType,
                AccountPassword = "1",
                AccountInvestorPassword = "2",
                Group = @group,
                Name = $"Autotest {accountingType.ToString()} account",
                IsTokenCommissionEnabled = isTokenCommissionEnabled,
                IsWebApiEnabled = true,
                MustChangePassword = mustChangePassword
            };

            if (accountingType != AccountingTypes.Cash)
            {
                newRequest.Balance = balance;
                newRequest.BalanceCurrency = balanceCurrency;
                newRequest.Leverage = leverage;
            }

            AccountInfo account = CreateAccount(newRequest);

            if (accountingType == AccountingTypes.Cash && balance != 0)
                DepositWithdrowal(account.AccountId, balance, balanceCurrency);

            return account;
        }

        public void DepositWithdrowal(DepositWithdrawalRequest request)
        {
            WaitForAccountUpdate(() => _manager.DepositWithdrawal(request), request.AccountId);
        }

        public void DepositWithdrowal(long accountId, decimal balance, string balanceCurrency)
        {
            WaitForAccountUpdate(() =>
                _manager.DepositWithdrawal(new DepositWithdrawalRequest
                {
                    AccountId = accountId,
                    Amount = balance,
                    Currency = balanceCurrency
                }), accountId);
        }

        public bool DeleteAccount(long accountId, bool closeOrders = true, bool deleteTradeHistory = true)
        {
            WaitForAccountUpdate(() => _manager.DeleteAccount(accountId, closeOrders, deleteTradeHistory), pumpingTransactionType: PumpingTransactionType.TRANS_DELETE);
            return true;
        }

        public AccountInfo GetAccountById(long accountLogin)
        {
            return _manager.GetAccountById(accountLogin);
        }

        public AccountInfo RequestAccountById(long accountLogin)
        {
            return _manager.RequestAccountById(accountLogin);
        }

        public void ModifyAccount(AccountModifyRequest accountModifyRequest)
        {
            WaitForAccountUpdate(() => _manager.ModifyAccount(accountModifyRequest), accountModifyRequest.AccountId);
        }

        public void DeleteAllAccount()
        {
            foreach (long id in _manager.RequestAllAccountLogins())
                DeleteAccount(id);
        }


        private long waitingOrderId;
        private PumpingTransactionType waitingOrderTransactionType;
        private EventWaitHandle orderWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);
        private object locker = new object();
        int waitingOrderNumberOfOperation;

        private void ModelPumpingUpdatePosition(object sender, PumpingUpdatePositionEventArgs e)
        {
            lock (locker)
            {
                waitingOrderNumberOfOperation--;
            }
            if ((e.Position.Id == waitingOrderId || waitingOrderId == 0) && e.TransactionType == waitingOrderTransactionType)
                orderWaitHandle.Set();
        }

        private void ModelPumpingUpdateOrder(object sender, PumpingUpdateOrderEventArgs e)
        {
            lock (locker)
            {
                waitingOrderNumberOfOperation--;
            }
            if ((e.Order.OrderId == waitingOrderId || waitingOrderId == 0) && e.TransactionType == waitingOrderTransactionType)
                orderWaitHandle.Set();
        }

        public void WaitForOrderUpdate(Action action, long orderId = 0, PumpingTransactionType pumpingTransactionType = PumpingTransactionType.TRANS_UPDATE, int timeout = 2000, int numberOfOperation = 0)
        {
            orderWaitHandle.Reset();
            waitingOrderTransactionType = pumpingTransactionType;
            waitingOrderId = orderId;
            waitingOrderNumberOfOperation = numberOfOperation;
            action.Invoke();
            if (numberOfOperation > 0)
            {
                do
                {
                    Thread.Sleep(1);
                    timeout--;
                    if (timeout < 0)
                    {
                        break;
                    }
                }
                while (waitingOrderNumberOfOperation > 0);
            }
            else
            {
                ;
                if (!orderWaitHandle.WaitOne(timeout))
                    throw new TimeoutException();
            }
        }

        public Order OpenOrder(OpenOrderRequest request, int timeout = 1000, int numberOfOperations = 0)
        {
            Order order = null;
            WaitForOrderUpdate(() => { order = _manager.OpenOrder(request); }, 0, PumpingTransactionType.TRANS_ADD, numberOfOperation: numberOfOperations);
            return order;
        }

        public bool ModifyOrder(OrderReplaceRequest request) => _manager.ModifyOrder(request);

        public Order RequestOrderById(long id) => _manager.RequestOrderById(id);

        public Order GetOrderById(long id) => _manager.GetOrderById(id);

        public IEnumerable<Order> RequestOrdersByAccountId(long id) => _manager.RequestOrdersByAccountId(id);

        public bool ActivateOrder(ActivateOrderRequest request) => _manager.ActivateOrder(request);

        public bool ClosePosition(ClosePositionRequest request) => _manager.ClosePosition(request);


        public TradeHistoryOverallReport RequestTradeReport(Order order)
        {
            var accounts = new List<long>();

            accounts.Add(order.AccountId);

            return _manager.QueryTradeHistoryOverall(new TradeHistoryOverallRequest
            {
                OrderId = order.OrderId,
                Accounts = accounts
            });
        }

        private string waitingCurrencyTypeName;
        private PumpingTransactionType waitingCurrencyTypeTransactionType;
        private EventWaitHandle currencyTypeWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);
        private void ModelPumpingUpdateCurrencyType(object sender, PumpingUpdateCurrencyTypeEventArgs e)
        {

            if (e.CurrencyType.Name == waitingCurrencyName)
                currencyTypeWaitHandle.Set();
        }

        private void WaitForCurrencyTypeUpdate(Action action, string currencyType, int timeout = 1000)
        {
            waitingCurrencyName = currencyType;

            action.Invoke();

            if (!currencyTypeWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public void CreateCurrencyType(CurrencyTypeNewRequest request, int timeout = 1000)
        {
            WaitForCurrencyTypeUpdate(() => _manager.CreateCurrencyType(request), request.Name, timeout);
        }


        public void DeleteCurrencyType(string currencyTypeName, int? configVersion = null, int timeout = 1000)
        {
            WaitForCurrencyTypeUpdate(() => _manager.DeleteCurrencyType(configVersion, currencyTypeName), currencyTypeName, timeout);
        }

        public void ModifyCurrencyType(CurrencyTypeModifyRequest request, int timeout = 1000)
        {
            WaitForCurrencyTypeUpdate(() => _manager.ModifyCurrencyType(request), request.NewName ?? request.Name, timeout);
        }



        private string waitingCurrencyName;
        private PumpingTransactionType waitingCurrencyTransactionType;
        private EventWaitHandle currencyWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);

        private void ModelPumpingUpdateCurrency(object sender, PumpingUpdateCurrencyEventArgs e)
        {
            if ((e.Currency.Name == waitingCurrencyName || waitingCurrencyName == null) && e.TransactionType == waitingCurrencyTransactionType)
                currencyWaitHandle.Set();
        }

        private void WaitForCurrencyUpdate(Action action, string currency, PumpingTransactionType pumpingTransactionType = PumpingTransactionType.TRANS_UPDATE, int timeout = 1000)
        {
            waitingCurrencyName = currency;
            waitingCurrencyTransactionType = pumpingTransactionType;

            action.Invoke();

            if (!currencyWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public void CreateCurrency(CurrencyNewRequest request, int timeout = 1000)
        {
            WaitForCurrencyUpdate(() => _manager.CreateCurrency(request), request.CurrencyName, PumpingTransactionType.TRANS_ADD, timeout);
        }


        public void DeleteCurrency(string currencyName, int? configVersion = null, int timeout = 1000)
        {
            WaitForCurrencyUpdate(() => _manager.DeleteCurrency(configVersion, currencyName), currencyName, PumpingTransactionType.TRANS_DELETE, timeout);
        }

        public void ModifyCurrency(CurrencyModifyRequest request, int timeout = 1000)
        {
            WaitForCurrencyUpdate(() => _manager.ModifyCurrency(request), request.NewCurrencyName ?? request.CurrencyName, PumpingTransactionType.TRANS_UPDATE, timeout);
        }

        public CurrencyInfo GetCurrency(string currency) => _manager.GetCurrency(currency);

        public SymbolTick RequestSymbolTick(string symbol)
        {
            try
            {
                return _manager.RequestSymbolTick(symbol);
            }
            catch
            {
                return new SymbolTick();
            }
        }



        //public void SendSymbolTicks(List<FeedTick> ticks, int timeout = 1000)
        //{
        //    if (ticks.Count == 0) return;

        //    _manager.SendSymbolTicks(ticks);

        //    var tick = ticks.Last();
        //    var _tick = SymbolTick.Convert(tick);

        //    int ts = 10; // time to sleep in ms
        //    int t = 0;
        //    while (t <= timeout)
        //    {
        //        if (_requestSymbolTick(tick.Symbol).EqualTo(_tick)) break;
        //        t += ts;
        //        Thread.Sleep(ts);
        //    }

        //    if (t >= timeout)
        //       throw new TimeoutException();
        //}

        /*private SymbolTick waitingSymbolTick;
        private PumpingTransactionType waitingSymbolTickTransactionType;
        private EventWaitHandle symbolTickWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);
        private int symbolTicksCounter = 0;

        private void ModelPumpingUpdateSymbolTick(object sender, PumpingUpdateSymbolTickEventArgs e)
        {
            //symbolTicksCounter++;
            //;
            //if (e.SymbolTick == waitingSymbolTick && e.TransactionType == waitingSymbolTickTransactionType)
                symbolTickWaitHandle.Set();
        }*/

        public bool SendSymbolTick2(FeedTick tick)
        {
            return true;

        }



        private FeedTick GenerateLastTick()
        {
            decimal ask, bid;
            ask = Convert.ToDecimal("1." + (rnd.Next() % 1000).ToString());
            bid = Convert.ToDecimal("1." + (rnd.Next() % 1000).ToString());
            var tick = new TTTick("TTT_SENDFLAG", ask, bid);
            return (FeedTick)tick;
        }

        public bool SendSymbolTicks(List<FeedTick> ticks, int timeout = 3000)
        {
            var lastTick = GenerateLastTick();
            ticks.Add(lastTick);
            _manager.SendSymbolTicks(ticks);
            while (timeout > 0)
            {
                if (lastTick.BestAsk.Price == RequestSymbolTick("TTT_SENDFLAG").Ask && lastTick.BestBid.Price == RequestSymbolTick("TTT_SENDFLAG").Bid)
                {
                    return true;
                }
                Thread.Sleep(1);
                timeout--;
            }
            throw new TimeoutException();
        }

        public bool SendSymbolTicks(List<TTTick> testTicks, int timeout = 3000)
        {
            if (testTicks.Count == 0) return true;

            return SendSymbolTicks(testTicks.Select(x => (FeedTick)x).ToList(), timeout);
        }

        public bool SendSymbolTick(TTTick tick, int timeout = 3000)
        {
            List<FeedTick> ticks = new List<FeedTick>();
            ticks.Add((FeedTick)tick);
            return SendSymbolTicks(ticks, timeout);
        }

        public bool SendSymbolTick(FeedTick tick, int timeout = 3000)
        {
            List<FeedTick> ticks = new List<FeedTick>();
            ticks.Add((FeedTick)tick);
            return SendSymbolTicks(ticks, timeout);
        }

        public SymbolTick GetSymbolTick(string symbol)
        {
            return _manager.GetSymbolTick(symbol);
        }


        public bool DeleteSymbolTicks(string symbol, FeedTickId from, FeedTickId to) => _manager.DeleteSymbolTicks(symbol, from, to);

        public SymbolTick RequestLevel2(string symbol, int depth)
        {
            return _manager.RequestLevel2(symbol, depth);
        }

        public bool ModifySymbol(SymbolModifyRequest request) => _manager.ModifySymbol(request);

        public void CreateSymbolSecurity(string name)
        {
            _manager.CreateSymbolSecurity(new SecurityNewRequest() { SecurityName = name, IgnoreConfigVersion = true });
        }

        public void DeleteSymbolSecurity(string name)
        {
            _manager.DeleteSymbolSecurity(null, name);
        }


        private string waitingSymbolName;
        private PumpingTransactionType waitingSymbolTransactionType;
        private EventWaitHandle symbolWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);
        private void ModelPumpingUpdateSymbol(object sender, PumpingUpdateSymbolConfigEventArgs e)
        {
            if (e.SymbolConfig.Symbol == waitingSymbolName && e.TransactionType == waitingSymbolTransactionType)
                symbolWaitHandle.Set();
        }

        private void WaitForSymbolUpdate(Action action, string symbol, PumpingTransactionType pumpingTransactionType = PumpingTransactionType.TRANS_UPDATE, int timeout = 1000)
        {
            waitingSymbolName = symbol;
            waitingSymbolTransactionType = pumpingTransactionType;
            action.Invoke();
            if (!symbolWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
            Thread.Sleep(1000);
        }

        public void CreateSymbol(SymbolNewRequest request, int timeout = 1000)
        {
            WaitForSymbolUpdate(() => _manager.CreateSymbol(request), request.SymbolName, PumpingTransactionType.TRANS_ADD, timeout);
        }

        public SymbolInfo GetSymbolConfig(string symbol) => _manager.GetSymbolConfig(symbol);

        public List<SymbolInfo> GetAllSymbolConfigs() => _manager.GetAllSymbolsConfigs();

        public void ModifySymbol(SymbolModifyRequest request, int timeout = 1000)
        {
            WaitForSymbolUpdate(() => _manager.ModifySymbol(request), request.SymbolName, PumpingTransactionType.TRANS_UPDATE, timeout);
        }

        public void DeleteSymbol(string symbol, int? configVersion = null, int timeout = 1000)
        {
            WaitForSymbolUpdate(() => _manager.DeleteSymbol(configVersion, symbol), symbol, PumpingTransactionType.TRANS_DELETE, timeout);
        }


        private string waitingSymbolSecurityName;
        private PumpingTransactionType waitingSymbolSecurityTransactionType;
        private EventWaitHandle symbolSecurityWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);


        private void ModelPumpingUpdateSymbolSecurity(object sender, PumpingUpdateSymbolSecurityEventArgs e)
        {
            if ((e.SymbolSecurity.Name == waitingSymbolSecurityName || waitingSymbolSecurityName == null) && e.TransactionType == waitingSymbolSecurityTransactionType)
                symbolSecurityWaitHandle.Set();
        }

        private void WaitForSymbolSecurityUpdate(Action action, string name, PumpingTransactionType pumpingTransactionType = PumpingTransactionType.TRANS_UPDATE, int timeout = 1000)
        {
            waitingSymbolSecurityName = name;
            waitingSymbolSecurityTransactionType = pumpingTransactionType;

            action.Invoke();

            if (!symbolSecurityWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public void CreateSymbolSecurity(SecurityNewRequest request)
        {
            WaitForSymbolSecurityUpdate(() => _manager.CreateSymbolSecurity(request), request.SecurityName, PumpingTransactionType.TRANS_ADD);
        }

        public void DeleteSymbolSecurity(string name, int? configVersion = null)
        {
            WaitForSymbolSecurityUpdate(() => _manager.DeleteSymbolSecurity(configVersion, name), name, PumpingTransactionType.TRANS_DELETE);
        }

        public void ModifySymbolSecurity(SecurityModifyRequest request)
        {
            WaitForSymbolSecurityUpdate(() => _manager.ModifySymbolSecurity(request), request.NewSecurityName ?? request.SecurityName, PumpingTransactionType.TRANS_UPDATE);
        }

        public SymbolSecurity GetSymbolSecurity(string name) => _manager.GetSymbolSecurity(name);

        public List<SymbolSecurity> GetAllSymbolSecurities() => _manager.GetAllSymbolsSecurities();

        private Guid? waitingGroupSecurityId;
        private PumpingTransactionType waitingGroupSecurityTransactionType;
        private EventWaitHandle groupSecurityWaitHandle = new AutoResetEvent(false);

        private void ModelPumpingUpdateGroupSecurity(object sender, PumpingUpdateGroupSecurityEventArgs e)
        {
            if (waitingGroupSecurityId.HasValue && e.GroupSecurity.Id == waitingGroupSecurityId && e.TransactionType == waitingGroupSecurityTransactionType)
                groupSecurityWaitHandle.Set();
        }

        public void CreateGroupSecurity(GroupSecurityNewRequest request, int timeout = 1000)
        {
            waitingGroupSecurityId = null;
            waitingGroupSecurityTransactionType = PumpingTransactionType.TRANS_ADD;

            _manager.CreateGroupSecurity(request);

            if (!groupSecurityWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public void ModifyGroupSecurity(GroupSecurityModifyRequest request, string group, string security, int timeout = 2000)
        {
            var z = _manager.GetAllGroupSecurities();
            ;
            var id = _manager.GetAllGroupSecurities().FirstOrDefault(x => x.Group == group && x.Security == security).Id;
            ;
            waitingGroupSecurityTransactionType = PumpingTransactionType.TRANS_UPDATE;
            request.GroupSecurityId = id.ToString();
            request.IgnoreConfigVersion = true;

            _manager.ModifyGroupSecurity(request);

            //if request no change groupsecurity we no get pumping event, just wait for timeout
            groupSecurityWaitHandle.WaitOne(timeout);

            return;
        }

        public void ModifyGroupSecurity(string currency, float value, CommissionValueType valueType, float minValue,
                                        ExecutionModes mode,
                                        string group, string security, int timeout = 1000)
        {
            var request = new GroupSecurityModifyRequest
            {
                CommissionMinValueCurrency = currency,
                CommissionValue = value,
                CommissionValueType = valueType,
                CommissionMinValue = minValue,
                CommissionValueBookOrders = 0,
                ChangeCommissionValueBookOrders = false,
                Execution = mode
            };

            ModifyGroupSecurity(request, group, security, timeout);
        }

        public List<GroupSecurity> RequestAllGroupSecurities() => _manager.RequestAllGroupSecurities();


        private string waitingGroupName;
        private PumpingTransactionType waitingGroupTransactionType;
        private EventWaitHandle groupWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);


        private void ModelPumpingUpdateGroup(object sender, PumpingUpdateGroupEventArgs e)
        {
            if (e.Group.Name == waitingGroupName && e.TransactionType == waitingGroupTransactionType)
                groupWaitHandle.Set();
        }

        public void WaitForGroupUpdate(Action action, string name, PumpingTransactionType pumpingTransactionType = PumpingTransactionType.TRANS_UPDATE, int timeout = 1000)
        {
            waitingGroupTransactionType = pumpingTransactionType;
            waitingGroupName = name;

            action.Invoke();

            if (!groupWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public void CreateGroup(GroupNewRequest request)
        {
            WaitForGroupUpdate(() => _manager.CreateGroup(request), request.GroupName, PumpingTransactionType.TRANS_ADD);
        }

        public void ModifyGroup(GroupModifyRequest request)
        {
            WaitForGroupUpdate(() => _manager.ModifyGroup(request), request.NewGroupName ?? request.GroupName, PumpingTransactionType.TRANS_UPDATE);
        }

        public void DeleteGroup(string name, int? configVersion = null)
        {
            WaitForGroupUpdate(() => _manager.DeleteGroup(configVersion, name), name, PumpingTransactionType.TRANS_DELETE);
        }

        public GroupInfo GetGroup(string name) => _manager.GetGroup(name);

        public List<GroupInfo> GetAllGroups() => _manager.GetAllGroups();

        private long waitingSplitId;
        private PumpingTransactionType waitingSplitTransactionType;
        private EventWaitHandle splitWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);

        private void ModelPumpingUpdateSplit(object sender, PumpingUpdateSplitEventArgs e)
        {
            if (e.Split.Id == waitingSplitId && e.TransactionType == waitingSplitTransactionType)
                splitWaitHandle.Set();
        }

        public void WaitForSplitUpdate(Action action, long splitId, PumpingTransactionType pumpingTransactionType = PumpingTransactionType.TRANS_UPDATE, int timeout = 1000)
        {
            waitingSplitTransactionType = pumpingTransactionType;
            waitingSplitId = splitId;

            action.Invoke();

            if (!splitWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public bool CreateSplit(SplitNewRequest splitNewRequest) => _manager.CreateSplit(splitNewRequest);


        public void DeleteSplit(long id, int timeout = 1000)
        {
            WaitForSplitUpdate(() => _manager.DeleteSplit(id), id, PumpingTransactionType.TRANS_DELETE);
        }

        public void DeleteAllSplit()
        {
            foreach (var split in RequestAllSplits())
            {
                DeleteSplit(split.Id);
            }
        }

        public IEnumerable<SplitInfo> RequestAllSplits() => _manager.RequestAllSplits();


        private string waitingDomainName;
        private PumpingTransactionType waitingDomainTransactionType;
        private EventWaitHandle domainWaitHandle = new EventWaitHandle(false, EventResetMode.AutoReset);

        private void ModelPumpingUpdateDomain(object sender, PumpingUpdateDomainEventArgs e)
        {
            if (e.Domain.DomainName == waitingDomainName && e.TransactionType == waitingDomainTransactionType)
                domainWaitHandle.Set();
        }

        public void WaitForUpdateDomain(Action action, string name, PumpingTransactionType pumpingTransactionType, int timeout = 1000)
        {
            waitingDomainTransactionType = pumpingTransactionType;
            waitingDomainName = name;

            action.Invoke();

            if (!domainWaitHandle.WaitOne(timeout))
                throw new TimeoutException();
        }

        public void ModifyDomain(DomainModifyRequest request, int timeout = 1000)
        {
            request.DomainDescription = _manager.ConfigVersion.ToString();
            WaitForUpdateDomain(() => _manager.ModifyDomain(request), request.NewDomainName ?? request.DomainName, PumpingTransactionType.TRANS_UPDATE);
            Thread.Sleep(1000);
        }


        public WebApiToken CreateWebApiToken(WebApiTokenNewRequest request) => _manager.CreateWebApiToken(request);

        public void Dispose()
        {
            if (CheckManagerIsConnected())
                Disconnect();

            _manager?.Dispose();
        }

        private bool CheckManagerIsConnected()
        {
            return (_manager == null || !_manager.IsConnected()) ? false : true;
        }

        public static double GetEpslion(decimal expectedvalue)
        {
            return Math.Pow(10, Math.Truncate(Math.Log10(Math.Abs((double)expectedvalue))) - 12);
        }

        public void CreateScheduledTask(IScheduledTaskInfo taskInfo) => _manager.CreateScheduledTask(taskInfo);
        public void UpdateScheduledTask(IScheduledTaskInfo taskInfo) => _manager.UpdateScheduledTask(taskInfo);
        public void CancelScheduledTask(Guid id) => _manager.CancelScheduledTask(id);
        public void DeleteScheduledTask(Guid id) => _manager.DeleteScheduledTask(id);
        public List<IScheduledTaskInfo> GetAllScheduledTasks() => _manager.GetAllScheduledTasks();
        public IScheduledTaskInfo GetScheduledTask(Guid id) => _manager.GetScheduledTask(id);

        public void PerformRollover(RolloverRequest request, long accountId, int timeout = 4000)
        {
            _manager.PerformRollover(request);
            /*Console.WriteLine(_manager.GetSymbolConfig("EURUSD").SwapEnabled);
            Console.WriteLine(_manager.GetSymbolConfig("EURUSD").SwapSizeLong);
            Console.WriteLine(_manager.GetSymbolConfig("EURUSD").SwapSizeShort);
            Console.WriteLine(request);
            Console.WriteLine(accountId);*/
            while (_manager.RequestAccountById(accountId).Swap == 0 && timeout > 0)
            {
                Thread.Sleep(1);
                timeout -= 1;
            }
            Thread.Sleep(100);
        }
    }
}
