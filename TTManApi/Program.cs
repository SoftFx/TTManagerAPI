using System;
using TickTrader.BusinessObjects;
using TickTrader.BusinessObjects.Requests;
using TickTrader.Manager.Model;

namespace TTManApi
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length != 3)
            {
                Console.WriteLine("Usage: TTManApi.exe TickTraderAddress ManagerLogin ManagerPassword");
                return;
            }

            string ttsAddress = args[0];
            string managerLogin = args[1];
            string managerPassword = args[2];

            try
            {
                // Create a new manager model
                using (var manager = new TickTraderManagerModel())
                {
                    // Connect manager model
                    manager.Connect(ttsAddress, long.Parse(managerLogin), managerPassword);

                    // Create a new account
                    var accountNewRequest = new AccountNewRequest
                    {
                        Name = "Test",
                        Group = "demoforex_cash",
                        AccountingType = AccountingTypes.Cash,
                        BalanceCurrency = "USD",
                        Leverage = 1
                    };
                    var account = manager.CreateAccount(accountNewRequest);
                    Console.WriteLine($"New Account Id = {account.AccountId}");

                    // Modify account
                    var accountModifyRequest = new AccountModifyRequest
                    {
                        AccountId = account.AccountId,
                        Comment = "My comment"
                    };
                    manager.ModifyAccount(accountModifyRequest);

                    // Perform deposit operation for account
                    var depositRequest = new DepositWithdrawalRequest()
                    {
                        AccountId = account.AccountId,
                        Currency = "USD",
                        Amount = 1000,
                        Comment = "My deposit"
                    };
                    var depositReport = manager.DepositWithdrawal(depositRequest);
                    Console.WriteLine($"Deposit transaction Id = {depositReport.OrderId}");

                    // Perform withdrawal operation for account
                    var withdrawalRequest = new DepositWithdrawalRequest()
                    {
                        AccountId = account.AccountId,
                        Currency = "USD",
                        Amount = -1000,
                        Comment = "My withdrawal"
                    };
                    var withdrawalReport = manager.DepositWithdrawal(withdrawalRequest);
                    Console.WriteLine($"Withdrawal transaction Id = {withdrawalReport.OrderId}");
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }
    }
}
