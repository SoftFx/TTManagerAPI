using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using log4net.Appender;
using log4net.Core;
using log4net.Layout;
using log4net.Repository.Hierarchy;

namespace rTTManApi
{
    public static class Logger
    {
        private static ILog log = LogManager.GetLogger("Logger");
        private static bool _isInit;

        public static ILog Log
        {
            get { return log; }
        }

        public static void InitLogger()
        {
            if (_isInit) return;
            _isInit = true;
            Hierarchy hierarchy = (Hierarchy) LogManager.GetRepository();

            PatternLayout patternLayout = new PatternLayout
            {
                ConversionPattern = "%date [%thread] %-5level %logger - %message%newline"
            };
            patternLayout.ActivateOptions();

            PatternLayout consoleLayout = new PatternLayout {ConversionPattern = "%message%newline"};
            consoleLayout.ActivateOptions();

            ConsoleAppender console = new ConsoleAppender {Layout = consoleLayout};
            console.ActivateOptions();
            hierarchy.Root.AddAppender(console);

            RollingFileAppender roller = new RollingFileAppender
            {
                AppendToFile = true,
                File = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) +
                       string.Format(@"\rTTManApi\Logs\{0}-{1}-{2} Log.txt", DateTime.Now.Year,
                           DateTime.Now.Month,
                           DateTime.Now.Day),
                Layout = patternLayout,
                MaxSizeRollBackups = 5,
                MaximumFileSize = "1GB",
                RollingStyle = RollingFileAppender.RollingMode.Size,
                StaticLogFileName = true
            };
            roller.ActivateOptions();
            hierarchy.Root.AddAppender(roller);

            MemoryAppender memory = new MemoryAppender();
            memory.ActivateOptions();
            hierarchy.Root.AddAppender(memory);

            hierarchy.Root.Level = Level.Info;
            hierarchy.Configured = true;
        }
    }
}
