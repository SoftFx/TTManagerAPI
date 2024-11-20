using TickTrader.BusinessObjects;

namespace TTManApi.Samples
{
    class GetAllOrders : Sample
    {
        public GetAllOrders(TTManager manager) : base(manager)
        {
        }

        public override void Dispose()
        {
        }

        public override void Run()
        {
            if (!Manager.DirectQuery.IsPumpingEnabled)
                Manager.EnablePumping();
            
            List<Order> Orders = Manager.DirectQuery.GetAllOrders();
            foreach (var item in Orders)
            {
                Console.WriteLine();
                Console.WriteLine(item.ToString());
            }
        }
    }
}
