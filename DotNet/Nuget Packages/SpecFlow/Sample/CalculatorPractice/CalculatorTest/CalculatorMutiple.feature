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