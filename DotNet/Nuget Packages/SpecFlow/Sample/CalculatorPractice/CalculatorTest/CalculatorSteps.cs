using CalculatorPractice;
using NUnit.Framework;
using System;
using TechTalk.SpecFlow;

namespace CalculatorTest
{
    [Binding]
    public class CalculatorSteps
    {
        private readonly Calculator _target;
        private readonly CalculatorContextDTO dto;

        public CalculatorSteps(CalculatorContextDTO dto)
        {
            _target = new Calculator();
            this.dto = dto;
        }

        [Given(@"I have entered first value (.*) into the calculator")]
        public void GivenIHaveEnteredFirstValueIntoTheCalculator(int first)
        {
            dto.first = first;
        }
        
        [Given(@"I have entered second value (.*) into the calculator")]
        public void GivenIHaveEnteredSecondValueIntoTheCalculator(int second)
        {
            dto.second = second;
        }
        
        [When(@"I press add")]
        public void WhenIPressAdd()
        {
            dto.actual = _target.Add(dto.first, dto.second);
        }
        
        [Then(@"the result should be (.*) on the screen")]
        public void ThenTheResultShouldBeOnTheScreen(int expected)
        {
            Assert.AreEqual(expected, dto.actual);
        }
    }

    public class CalculatorContextDTO
    {
        public int first;
        public int second;
        public int actual;
    }
}
