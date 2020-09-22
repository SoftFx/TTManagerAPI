using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using TickTrader.BusinessObjects;

namespace TTManApi
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
                    var tickHistory = Manager.DirectQuery.QueryTickHistory(DateTime.UtcNow, -100, symbol.Symbol, true);
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
