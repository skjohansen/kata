using Kata.Application.Console;

namespace Kata.Application;

class Program
{
    static void Main(string[] args)
    {
        KataRunner kataRunner = new KataRunner(new ConsoleWrapper());
        kataRunner.Run();
    }
}
