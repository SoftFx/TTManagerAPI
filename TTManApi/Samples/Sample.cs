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
