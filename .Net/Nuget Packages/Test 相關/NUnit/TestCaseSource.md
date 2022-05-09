# [TestCaseSource](https://docs.nunit.org/articles/nunit/writing-tests/attributes/testcasesource.html)

由另一個 static object[] 來提供 TestCase 資料來源 !

-   可再搭配 static 變數，做更簡化的給定

### 範例一

```cs
public class MyTestClass
{
    static object[] DivideCases =
    {
        new object[] { 12, 3, 4 },
        new object[] { 12, 2, 6 },
        new object[] { 12, 4, 3 }
    };
    [TestCaseSource(nameof(DivideCases))]
    public void DivideTest(int n, int d, int q)
    {
        Assert.AreEqual(q, n / d);
    }
}
}
```

### 範例二

```cs
public class ParkingFeeCalculatorTests
{
    private static DateTime _zeroDateTime = new DateTime(1, 1, 1, 0, 0, 0);

    static object[] Below10MinutesTestCases =
    {
        new object[] { _zeroDateTime, _zeroDateTime },
        new object[] { _zeroDateTime.AddMinutes(1), _zeroDateTime.AddMinutes(5) },
    };

    [Test]
    [TestCaseSource(nameof(Below10MinutesTestCases))]
    public void 十分鐘內_為_0_元(DateTime from, DateTime to)
    {
        var actual = GetTarget().Fees(from, to);

        Assert.AreEqual(0, actual);
    }

    static object[] From11To30MinutesTestCases =
    {
        new object[] { _zeroDateTime, _zeroDateTime.AddMinutes(11) },
        new object[] { _zeroDateTime, _zeroDateTime.AddMinutes(30) },
    };

    [Test]
    [TestCaseSource(nameof(From11To30MinutesTestCases))]
    public void 十一分鐘至三十分鐘_為_7_元(DateTime from, DateTime to)
    {
        var actual = GetTarget().Fees(from, to);

        Assert.AreEqual(7, actual);
    }

    static object[] From31To59MinutesTestCases =
    {
        new object[] { _zeroDateTime, _zeroDateTime.AddMinutes(31) },
        new object[] { _zeroDateTime, _zeroDateTime.AddMinutes(59) },
    };

    [Test]
    [TestCaseSource(nameof(From31To59MinutesTestCases))]
    public void 三十一分鐘至五十九分鐘_為_10_元(DateTime from, DateTime to)
    {
        var actual = GetTarget().Fees(from, to);

        Assert.AreEqual(10, actual);
    }

    static object[] PerHoursTestCases =
    {
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(1), 10 },
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(2), 20 },
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(3), 30 },
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(4), 40 },
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(5), 50 },
    };

    [Test]
    [TestCaseSource(nameof(PerHoursTestCases))]
    public void 每小時_為_10_元(DateTime from, DateTime to, int expected)
    {
        var actual = GetTarget().Fees(from, to);

        Assert.AreEqual(expected, actual);
    }

    static object[] From_0101_To_0130_MinutesTestCases =
    {
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(1).AddMinutes(1) },
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(1).AddMinutes(30) },
    };

    [Test]
    [TestCaseSource(nameof(From_0101_To_0130_MinutesTestCases))]
    public void 一小時_1分_至_小於等於30分_為_17_元(DateTime from, DateTime to)
    {
        var actual = GetTarget().Fees(from, to);

        Assert.AreEqual(17, actual);
    }

    static object[] From_0130_To_0159_MinutesTestCases =
    {
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(1).AddMinutes(31) },
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(1).AddMinutes(59) },
    };

    [Test]
    [TestCaseSource(nameof(From_0130_To_0159_MinutesTestCases))]
    public void 一小時_大於30分_為_20_元(DateTime from, DateTime to)
    {
        var actual = GetTarget().Fees(from, to);

        Assert.AreEqual(20, actual);
    }

    static object[] EqualOrOver_5_HoursTestCases =
    {
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(5).AddMinutes(1) },
        new object[] { _zeroDateTime, _zeroDateTime.AddHours(23).AddMinutes(59) },
    };

    [Test]
    [TestCaseSource(nameof(EqualOrOver_5_HoursTestCases))]
    public void 大於等於5小時_為_50_元(DateTime from, DateTime to)
    {
        var actual = GetTarget().Fees(from, to);

        Assert.AreEqual(50, actual);
    }

    private static ParkingFeeCalculator GetTarget()
    {
        return new ParkingFeeCalculator(new ParkingMinutesCalculator());
    }
}
```
