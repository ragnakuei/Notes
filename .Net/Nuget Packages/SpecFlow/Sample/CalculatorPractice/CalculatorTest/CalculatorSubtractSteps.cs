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
