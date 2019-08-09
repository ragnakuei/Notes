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