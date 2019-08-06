Feature: CalculatorAdd
	Practice SpecFlow 3 @dotnet core

@Add
Scenario: Add two numbers
	Given I have entered first value 50 into the calculator
	And I have entered second value 70 into the calculator
	When I press add
	Then the result should be 120 on the screen
