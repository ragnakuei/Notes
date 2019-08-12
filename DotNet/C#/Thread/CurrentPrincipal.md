# [Thread.CurrentPrincipal Property](https://docs.microsoft.com/zh-tw/dotnet/api/system.threading.thread.currentprincipal?view=netframework-4.8)

透過 Thread.CurrentPrincipal 設定目前可用的 Role

再透過 PrincipalPermission Attrubite 來檢查目前是否附合權限

```csharp
void Main()
{
    try
    {
        var identity = new GenericIdentity(name: "Bob", type: "Passport");
        var rolesArray = new []{ PermissionLevel.A1, PermissionLevel.A2 };

        // Set
        Thread.CurrentPrincipal = new GenericPrincipal(identity: identity, roles: rolesArray);

        Test1();
        Test2();
    }
    catch (SecurityException secureException)
    {
        Console.WriteLine("{0}: Permission to set Principal " + "is denied.", secureException.GetType().Name);
    }

    // Display
    IPrincipal threadPrincipal = Thread.CurrentPrincipal;
    Console.WriteLine("Name: {0}\nIsAuthenticated: {1}" + "\nAuthenticationType: {2}",
                        threadPrincipal.Identity.Name,
                        threadPrincipal.Identity.IsAuthenticated,
                        threadPrincipal.Identity.AuthenticationType);
}

[PrincipalPermission(SecurityAction.Demand, Role = PermissionLevel.A1)]
public void Test1() 
{ 
    "Have Permission".Dump();
}

[PrincipalPermission(SecurityAction.Demand, Role = PermissionLevel.A3)]
public void Test2()
{
    "Have Permission".Dump();
}

public static class PermissionLevel
{
    public const string A1 = "A1";
    public const string A2 = "A2";
    public const string A3 = "A3";
    public const string A4 = "A4";
    public const string A5 = "A5";
}
```
