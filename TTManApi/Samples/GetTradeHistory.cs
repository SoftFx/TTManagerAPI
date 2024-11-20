using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TickTrader.BusinessObjects;
using TickTrader.BusinessObjects.Requests;

namespace TTManApi.Samples
{
    class GetTradeHistory : Sample
    {
        private readonly long _account;

        public GetTradeHistory(TTManager manager, long account) : base(manager)
        {
            _account = account;
        }

        public override void Dispose()
        {
        }

        public override void Run()
        {
            var request = new TradeHistoryOverallRequest
            {
                SkipCancelOrder = true
            };

            request.Accounts.Add(_account);
            request.Streaming.Direction = StreamingDirections.Forward;
            request.Streaming.BufSize = 1000;

            bool stop = false;
            do
            {
                var response = Manager.DirectQuery.QueryTradeHistoryOverall(request);
                if (response.Reports.Any())
                {
                    foreach (var report in response.Reports)
                    {
                        Console.WriteLine(report);
                    }
                    request.Streaming.PosId = response.LastId;
                }
                stop = response.IsEndOfStream;
            } while (!stop);
        }
    }
}
