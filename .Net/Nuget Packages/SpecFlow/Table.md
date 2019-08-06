# Table

## [CreateInstance](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#createinstance)、[CompareToInstance](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#comparetoinstance)

將 feature Table 轉成 instance

feature

```
Feature: CalculatorSubtract
	Practice SpecFlow 3 @dotnet core

@Subtract
Scenario: Subtract two numbers
	Given I have entered the following numbers
	| first | second |
	| 3     | 1      |
	When I press substract
	Then the result should be the folloing
	| answer |
	| 2      |
```

step

```csharp
using CalculatorPractice;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CalculatorTest
{
    [Binding]
    [Scope(Tag = "Multiple")]

    public class CalculatorMultipleSteps
    {
        private readonly Calculator _target;
        private IEnumerable<CalculatorMultipleContext> _context;

        public CalculatorMultipleSteps()
        {
            _target = new Calculator();
        }

        [Given(@"I have entered the following multiple numbers")]
        public void GivenIHaveEnteredTheFollowingNumbers(Table table)
        {
            _context = table.CreateSet<CalculatorMultipleContext>();
        }

        [When(@"I press multiple")]
        public void WhenIPressMultiple()
        {
            foreach (var context in _context)
            {
                context.Actual = _target.Multiple(context.First, context.Second);
            }
        }

        [Then(@"the result should be the folloing")]
        public void ThenTheResultShouldBeTheFolloing(Table table)
        {
            table.CompareToSet(_context);
        }
    }
    public class CalculatorMultipleContext
    {
        public int First { get; set; }
        public int Second { get; set; }
        public int Actual { get; set; }
    }
}
```

## [CreateSet](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#createset)、[CompareToSet](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#comparetoset)

將 feature Table 轉成 IEnumerable<T>

feature

```
Feature: CalculatorMultiple
	Practice SpecFlow 3 @dotnet core

@Multiple
Scenario: Multiple two numbers
	Given I have entered the following multiple numbers
	| first | second |
	| 2     | 3      |
	| 3     | 4      |
	When I press multiple
	Then the result should be the folloing
	| answer |
	| 6      |
	| 12     |
```

step

```csharp
using CalculatorPractice;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CalculatorTest
{
    [Binding]
    [Scope(Tag = "Multiple")]

    public class CalculatorMultipleSteps
    {
        private readonly Calculator _target;
        private IEnumerable<CalculatorMultipleContext> _context;

        public CalculatorMultipleSteps()
        {
            _target = new Calculator();
        }

        [Given(@"I have entered the following multiple numbers")]
        public void GivenIHaveEnteredTheFollowingNumbers(Table table)
        {
            _context = table.CreateSet<CalculatorMultipleContext>();
        }

        [When(@"I press multiple")]
        public void WhenIPressMultiple()
        {
            foreach (var context in _context)
            {
                context.Actual = _target.Multiple(context.First, context.Second);
            }
        }

        [Then(@"the result should be the folloing")]
        public void ThenTheResultShouldBeTheFolloing(Table table)
        {
            table.CompareToSet(_context.Select(i => new { Answer = i.Actual }));
        }
    }
    public class CalculatorMultipleContext
    {
        public int First { get; set; }
        public int Second { get; set; }
        public int Actual { get; set; }
    }
}
```
