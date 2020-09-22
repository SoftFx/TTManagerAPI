using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using TickTrader.BusinessObjects;
using TickTrader.BusinessObjects.EventArguments;
using TickTrader.BusinessObjects.Requests;

namespace TTManApi
{
    class WaitForOrderPositionUpdate :Sample
    {
        private readonly long _account;

        public WaitForOrderPositionUpdate(TTManager manager, long account) : base(manager)
        {
            _account = account;
            Manager.DirectQuery.PumpingUpdateOrder += ManagerOnPumpingUpdateOrderAsync;
            Manager.DirectQuery.PumpingUpdatePosition += ManagerOnPumpingUpdatePosition;
        }

        public override void Run()
        {
            try
            {
                var tick = Manager.DirectQuery.GetSymbolTick("EURUSD");
                Order order = Manager.DirectQuery.OpenOrder(OpenOrderRequest.CreateClient(_account, OrderTypes.Limit,
                    OrderSides.Buy, "EURUSD", 10000, null, tick.Ask - 0.00009m, null, null, null, null, null, null, 0, null));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            Console.WriteLine("Press any key to exit...");
            Console.ReadKey();
        }

        public override void Dispose()
        {
            Manager.DirectQuery.PumpingUpdateOrder -= ManagerOnPumpingUpdateOrderAsync;
            Manager.DirectQuery.PumpingUpdatePosition -= ManagerOnPumpingUpdatePosition;
        }

        private async void ManagerOnPumpingUpdateOrderAsync(object sender, PumpingUpdateOrderEventArgs args)
        {
            if (args.TransactionType == PumpingTransactionType.TRANS_ADD)
            {
                await Task.Run(() =>
                {
                    Console.WriteLine($"\nOrder #{args.Order.OrderId} created Status={args.Order.Status}.\n {args.Order}");
                });
            }
            else if (args.TransactionType == PumpingTransactionType.TRANS_UPDATE)
            {
                await Task.Run(() =>
                {
                    Console.WriteLine($"\nOrder #{args.Order.OrderId} updated Status={args.Order.Status}\n {args.Order}");
                });
            }
            else if (args.TransactionType == PumpingTransactionType.TRANS_DELETE)
            {
                if ((args.Order.Type == OrderTypes.Position || args.Order.Type == OrderTypes.Market) && args.Order.Status == OrderStatuses.Filled)
                {
                    await Task.Run(() =>
                    {
                        Console.WriteLine($"\nOrder #{args.Order.OrderId} closed Status={args.Order.Status}.\n {args.Order}");
                        GetHistoryOverallReport(args.Order.OrderId);
                    });
                }
                else
                {
                    await Task.Run(() =>
                    {
                        Console.WriteLine($"\nOrder #{args.Order.OrderId} deleted Status={args.Order.Status}.\n {args.Order}");
                    });
                }
            }
        }

        private async void ManagerOnPumpingUpdatePosition(object sender, PumpingUpdatePositionEventArgs args)
        {
            if (args.TransactionType == PumpingTransactionType.TRANS_ADD)
            {
                await Task.Run(() =>
                {
                    Console.WriteLine($"\nNetPosition #{args.Position.Id} added.\n{args.Position}");
                });
            }
            else if (args.TransactionType == PumpingTransactionType.TRANS_UPDATE)
            {
                await Task.Run(() =>
                {
                    Console.WriteLine($"\nNetPosition #{args.Position.Id} updated.\n{args.Position}");
                });
            }
            else if (args.TransactionType == PumpingTransactionType.TRANS_DELETE)
            {
                await Task.Run(() =>
                {
                    Console.WriteLine($"\nNetPosition #{args.Position.Id} Symbol {args.Position.Symbol} deleted.\n{args.Position}");
                });
            }
        }

        private void GetHistoryOverallReport(long orderId)
        {
            do
            {
                try
                {
                    var report = Manager.DirectQuery.QueryTradeHistoryOverall(new TradeHistoryOverallRequest { OrderId = orderId });
                    foreach (TradeReport tradeReport in report.Reports)
                    {
                        Console.WriteLine($"\nTradeReport {tradeReport}");
                    }
                    return;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                Thread.Sleep(2000);
            } while (true);
        }
    }
}
