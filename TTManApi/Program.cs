﻿using TTManApi.Samples;

namespace TTManApi
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 4)
            {
                Console.WriteLine("Usage: TTManApi.exe serverAddress managerLogin managerPassword userAccount");
                return;
            }

            try
            {
                string ttsAddress = args[0];
                long.TryParse(args[1], out var managerLogin);
                string managerPassword = args[2];
                long.TryParse(args[3], out var account);

                using (TTManager manager = new TTManager(ttsAddress, managerLogin, managerPassword, true))
                //using (Sample sample = new WaitForOrderPositionUpdate(manager, account))
                //using (Sample sample = new SubscribeLastTrades(manager, new []{"EURUSD"}))
                //using (Sample sample = new GetAllOrders(manager))
                //using (Sample sample = new WaitForAccountUpdate(manager, account))
                //{
                //    sample.Run();
                //    //Console.ReadKey();
                //}
                using (Sample sample = new GetTradeHistory(manager, account))
                {
                    sample.Run();
                    Console.ReadKey();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }
    }
}
