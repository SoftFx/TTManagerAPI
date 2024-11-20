namespace TTManApi.Samples
{
    class WaitForAccountUpdate : Sample
    {
        private readonly long _account;

        public WaitForAccountUpdate(TTManager manager, long account) : base(manager)
        {
            _account = account;
            Manager.DirectQuery.PumpingUpdateAllAccounts += ModelPumpingUpdateAllAccounts;
            Manager.DirectQuery.PumpingUpdateAccount += ModelPumpingUpdateAccount;
        }

        public override void Dispose()
        {
            Manager.DirectQuery.PumpingUpdateAllAccounts -= ModelPumpingUpdateAllAccounts;
            Manager.DirectQuery.PumpingUpdateAccount -= ModelPumpingUpdateAccount;
        }

        public override void Run()
        {
            Console.ReadKey();
        }

        private void ModelPumpingUpdateAllAccounts(object sender, EventArgs e)
        {
            var acc = Manager.GetAccountById(_account);
            Console.WriteLine($"\nPumpingUpdateAllAccounts: {acc}");
        }

        private void ModelPumpingUpdateAccount(object sender, TickTrader.BusinessObjects.EventArguments.PumpingUpdateAccountEventArgs e)
        {
            if (e.Account.AccountId == _account)
                Console.WriteLine($"\nPumpingUpdateAccount: {e.Account}");
        }

    }
}
