using TickTrader.BusinessObjects;
using TickTrader.BusinessObjects.EventArguments;
using TickTrader.Common.Business;

namespace TTManApi.Samples
{
    class SubscribeLastTrades : Sample
    {
        private readonly string[] _subscription;
        public SubscribeLastTrades(TTManager manager, string[] subscription) : base(manager)
        {
            _subscription = subscription;
        }

        public override void Run()
        {
            if (!Manager.DirectQuery.IsPumpingEnabled)
                Manager.EnablePumping();

            List<string> lastsToSubsribe = new List<string>(_subscription.Select(s => $"{s}_L"));
            var domains = Manager.DirectQuery.GetAllDomains();
            var prefixes = domains.Select(d => d.LastTradesSecurityPrefix).ToList();
            foreach (string prefix in prefixes)
            {
                if (string.IsNullOrEmpty(prefix))
                    continue;
                lastsToSubsribe.AddRange(_subscription.Select(s => $"[{prefix}]{s}_L"));
            }
            Manager.DirectQuery.Level2Subscribe(lastsToSubsribe.ToArray(), 2);
            Manager.DirectQuery.PumpingUpdateSymbolTick += OnPumpingUpdateSymbolTick;
        }

        private void OnPumpingUpdateSymbolTick(object sender, PumpingUpdateSymbolTickEventArgs args)
        {
            ShowLastTrade(args.SymbolTick);
        }

        public override void Dispose()
        {
        }

        private void ShowLastTrade(SymbolTick tick)
        {
            if (tick.Level2 == null)
                return;
            FeedLevel2Record l2 = tick.Level2[0];
            string side = l2.Type == FxPriceType.Ask ? "Buy" : "Sell";
            Console.WriteLine($"{tick.Symbol} {side} {l2.Volume} {l2.Price} {tick.Time:s}");
        }
    }
}
