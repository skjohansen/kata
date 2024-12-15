using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit.Abstractions;

namespace Kata.Logic.Test;

public class KataTests(ITestOutputHelper output)
{
    [Fact]
    public void MethodName_StateUnderTest_ExpectedBehavior1()
    {
        output.WriteLine("Test steps");

        // Arrange
        var sut = new Kata();
        
        // Assert
    }

    [Fact(DisplayName = "Pretty name")]
    public void MethodName_StateUnderTest_ExpectedBehavior2()
    {
        // Arrange
        // Act
        // Assert
 
    }

    
}
