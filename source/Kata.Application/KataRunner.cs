using Kata.Application.Console;

namespace Kata.Application
{
    public class KataRunner
    {
        IConsole _console;
        public KataRunner(IConsole consoleDi)
        {
            _console = consoleDi;
        }

        public void Run()
        {
            _console.WriteLine("Welcome to the Kata!");
        }
    }
}
