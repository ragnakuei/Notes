# 驗証自訂 Exceptioin 的 Property

自訂 Exception 為

```cs
public class AlertException : Exception
{
    public string? AlertMessage { get; }
    public string? RedirectUrl { get; set; }

    public AlertException(string? alertMessage,
                          string? message = null,
                          string? redirectUrl = null) : base(message)
    {
        AlertMessage = alertMessage;
        RedirectUrl = redirectUrl;
    }

    public AlertException(string? alertMessage,
                          Exception innerException,
                          string? message = null)
        : base(message, innerException)
    {
        AlertMessage = alertMessage;
    }
}
```

搭配 Mock 的驗証語法

語法一：

```cs
// Arrange
var org = "52";

var permissionServiceMock = new Mock<IPermissionService>();
permissionServiceMock.Setup(m => m.ValidateViewPermission(org))
                     .Throws(new AlertException("無權限"));

var target = new Service(permissionServiceMock.Object,
                         new Mock<IPrjFilterSettingsRepository>().Object);

// Act
// Assert
target.Invoking(m => m.Get(org))
      .Should()
      .Throw<AlertException>()
      .Which.AlertMessage.Should()
      .BeEquivalentTo("無權限");
```

語法二：

```cs
// Arrange
var org = "52";

var permissionServiceMock = new Mock<IPermissionService>();
permissionServiceMock.Setup(m => m.ValidateViewPermission(org))
                     .Throws(new AlertException("無權限"));

var target = new Service(permissionServiceMock.Object,
                         new Mock<IPrjFilterSettingsRepository>().Object);

// Act
Action act = () => target.Get(org);

// Assert
act.Should()
   .Throw<AlertException>()
   .Which.AlertMessage.Should()
   .BeEquivalentTo("無權限");
```
