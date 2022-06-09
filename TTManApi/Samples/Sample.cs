using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TTManApi.Samples
{
    abstract class Sample : IDisposable
    {
        public TTManager Manager { get; }

        public Sample(TTManager manager)
        {
            Manager = manager;
        }

        public abstract void Run();
        public abstract void Dispose();
    }
}
