# Exception

## 語法1

 ```csharp
[Test]
public void Should_not_convert_from_prinergy_date_time_sample2()
{
    //Arrange
    string testDate = "20121123120122";

    //Act
    ActualValueDelegate<object> testDelegate = () => testDate.FromPrinergyDateTime();

    //Assert
    Assert.That(testDelegate, Throws.TypeOf<FormatException>());
}
```

## 語法2

```csharp
[Test]
public void 驗證Exception2()
{
    var target = new Calculator();

    Assert.Catch<CustomException>(() => target.Divided(1 , 0));
}
```

## 要驗證 Exception Message 的方式

也可以改用 驗證 Exception Property 的方式

```csharp
Assert.That(() => new ApplicationArguments(args),
            Throws.TypeOf<ArgumentException>()
                  .With.Message.EqualTo("Invalid ending parameter of the workbook. Please use .xlsx random random"));
```

## 驗證 Custom Exception Property 的方式

```csharp
[Test]
public void VO_為_NULL()
{
    OrgChangeFormVO formVO = null;

    var ex = Assert.Throws<VaildDataException>(()=>_target.PostNew(formVO));
    Assert.That(ex.ErrorValueObject.Detail, Is.EqualTo(FoundationLanguagePack.SH_NoRequiredData));
}
```
