namespace Kata.Application.Console
{
    public class ConsoleWrapper : IConsole
    {
        public void WriteLine(string message)
        {
            System.Console.WriteLine(message);
        }
    }
}