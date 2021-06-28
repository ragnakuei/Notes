# example 範例

對應於 NUnit 的 TestCase Attribute 

```
Feature: Calculator

    Scenario: 第一個數字是奇數
        Given 第一個數字是 <first>
        And 第二個數字是 <second>
        When 經過樂透判斷
        Then 得到<expected>元

    Examples:
      | first | second | expected |
      | 1     | 1      | 100      |
      | 3     | 1      | 100      |
      | 5     | 1      | 100      |
      | 7     | 1      | 100      |
      | 9     | 1      | 100      |

    Scenario: 第二個數字是2、5、8
        Given 第一個數字是 <first>
        And 第二個數字是 <second>
        When 經過樂透判斷
        Then 得到<expected>元

    Examples:
      | first | second | expected |
      | 1     | 2      | 200      |
      | 3     | 5      | 200      |
      | 5     | 8      | 200      |
```