using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using TickTrader.BusinessObjects;
using TickTrader.BusinessObjects.QuoteHistory;
using TickTrader.Common.Business;

namespace TTManApi.Samples
{
    class QuoteHistory : Sample
    {
        private Thread _thread;
        private bool _stop;

        public QuoteHistory(TTManager manager) : base(manager)
        {
            _thread = new Thread(Start);
        }

        private void Start()
        {
            List<SymbolInfo> symbols = Manager.DirectQuery.GetAllSymbolsConfigs();
            while (!_stop)
            {
                foreach (SymbolInfo symbol in symbols)
                {
                    //var tickHistory = Manager.DirectQuery.QueryTickHistory(DateTime.UtcNow, -100, symbol.Symbol, true);
                    MarketHistoryItemsReport<HistoryBar> itemsReport = Manager.DirectQuery.QueryBarHistory(DateTime.UtcNow.Date, -1, symbol.Symbol, "D1", FxPriceType.Bid);
                    foreach (HistoryBar bar in itemsReport.Items)
                    {
                        Console.WriteLine(bar);
                    }
                    Thread.Sleep(100);
                }
            }
        }

        public override void Run()
        {
            _thread.Start();
        }

        public override void Dispose()
        {

        }
    }
}
