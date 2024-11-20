using TickTrader.BusinessObjects;
using TickTrader.Common.Business;

namespace TTManApi
{
    public class TTTick : IEquatable<TTTick>
    {
        public string Symbol { get; set; }
        public decimal Ask { get; set; }
        public decimal Bid { get; set; }
        public double AskVolume { get; set; }
        public double BidVolume { get; set; }

        public TTTick() { }

        public TTTick(string symbol, decimal ask, decimal bid) : this(symbol, ask, 100, bid, 100) { }

        public TTTick(string symbol, decimal ask, double askVolume, decimal bid, double bidVolume)
        {
            Symbol = symbol;
            Ask = ask;
            Bid = bid;
            AskVolume = askVolume;
            BidVolume = bidVolume;
        }

        public bool Equals(TTTick other)
        {
            if (other == null) return false;
            return Symbol == other.Symbol && Ask == other.Ask && Bid == other.Bid;
        }

        public override bool Equals(object obj) => Equals(obj as TTTick);
        public override int GetHashCode() => (Symbol, Ask, Bid).GetHashCode();

        public static explicit operator FeedTick(TTTick tick)
        {
            var level2 = new List<FeedLevel2Record>();

            if (tick.Ask != 0)
                level2.Add(new FeedLevel2Record { Type = FxPriceType.Ask, Price = tick.Ask < 0M ? -tick.Ask : tick.Ask, Volume = tick.Ask < 0M ? -tick.AskVolume : tick.AskVolume });

            if (tick.Bid != 0)
                level2.Add(new FeedLevel2Record { Type = FxPriceType.Bid, Price = tick.Bid < 0M ? -tick.Bid : tick.Bid, Volume = tick.Bid < 0M ? -tick.BidVolume : tick.BidVolume });

            return new FeedTick(tick.Symbol, new FeedTickId(DateTime.UtcNow), level2.ToArray());
        }
    }
}
