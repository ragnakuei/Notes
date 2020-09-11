# Feature-Policy

阻擋手機可使用的功能，大多數的網站不會用到手機功能 !

```csharp
app.Use(async (context, next) =>
        {
            context.Response.Headers.Add("Feature-Policy", "accelerometer 'none'; camera 'none'; geolocation 'none'; gyroscope 'none'; magnetometer 'none'; microphone 'none'; payment 'none'; usb 'none'");

            await next();
        });
```
