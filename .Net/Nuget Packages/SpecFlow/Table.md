# Table

## Column Naming

Table Column 的名稱不需要與 Class Property Name 一模一樣

可以有空白間隔、不區分大小寫

例：FirstName 與 First name 都是相同的欄位

## [CreateInstance](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#createinstance)、[CompareToInstance](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#comparetoinstance)

將 feature Table 轉成 instance

### feature

instance property 水平展開

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

或是 instance property 垂直展開，分別以 field、value 表示欄位名稱及欄位值

```
Feature: CalculatorSubtract
	Practice SpecFlow 3 @dotnet core

@Subtract
Scenario: Subtract two numbers
	Given I have entered the following numbers
	| field  | value |
	| first  | 3     |
	| second | 1     |
	When I press substract
	Then the result should be the folloing
	| field  | value |
	| answer | 2     |
```

### step

CompareToInstance 可以跟 Anonymous Class 比較

```csharp
using CalculatorPractice;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CalculatorTest
{
    [Binding]
    [Scope(Tag = "Subtract")]
    public class CalculatorSubtractSteps
    {
        private readonly Calculator _target;
        private CalculatorSubtractContext _context;

        public CalculatorSubtractSteps()
        {
            _target = new Calculator();
        }

        [Given(@"I have entered the following numbers")]
        public void GivenIHaveEnteredTheFollowingNumbers(Table table)
        {
            _context = table.CreateInstance< CalculatorSubtractContext>();
        }

        [When(@"I press substract")]
        public void WhenIPressSubstract()
        {
            _context.Actual = _target.Subtract(_context.First, _context.Second);
        }

        [Then(@"the result should be the folloing")]
        public void ThenTheResultShouldBeOnTheScreen(Table table)
        {
            table.CompareToInstance(new { Answer = _context.Actual });
        }
    }

    public class CalculatorSubtractContext
    {
        public int First { get; set; }
        public int Second { get; set; }
        public int Actual { get; set; }
    }
}
```

## [CreateSet](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#createset)、[CompareToSet](https://github.com/techtalk/SpecFlow/wiki/SpecFlow-Assist-Helpers#comparetoset)

將 feature Table 轉成 IEnumerable<T>

### feature

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

### step

CompareToSet 可以跟 IEnumerable<T> T 是 Anonymous Class 比較

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
