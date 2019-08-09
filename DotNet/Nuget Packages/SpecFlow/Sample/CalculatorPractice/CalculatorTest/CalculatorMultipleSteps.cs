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
