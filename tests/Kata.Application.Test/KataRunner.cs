using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Kata.Application.Console;
using Kata.Application.Test.Mocks;

namespace Kata.Application.Test;

public class GameRunnerTests
{
    [Fact]
    public void Run_WelcomeMessageIsPresented()
    {
        // Arrange
        IConsole consoleMock = new ConsoleWrapperMock();
        var sut = new KataRunner(consoleMock);
        // Act
        sut.Run();
        // Assert
        Assert.Equal("Welcome to the Kata!", ((ConsoleWrapperMock)consoleMock).LineToWrite);
    }
}
