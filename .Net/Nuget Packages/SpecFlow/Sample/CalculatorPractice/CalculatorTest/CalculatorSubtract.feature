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
