# Calendar API

Google 帳號類似型為 Google Service Account !

Event
    - [ColorId](../../../APIs/Google/Calendar/Calendar%20API.md#ColorId) - 可設定顏色

## 範例

```csharp
public class GoogleCalendarService : IGoogleCalendarService
{
    public GoogleCalendarService(IConfiguration                 configuration,
                                    IPathService                   pathService,
                                    ILogger<GoogleCalendarService> logger)
    {
        _configuration = configuration;
        _pathService   = pathService;
        _logger   = logger;

        _calendarService = GetCalendarService();
    }

    private string CalendarId => _configuration.GetSection(AppSettingsKey.GoogleCalendarId).Value;

    private readonly IConfiguration _configuration;

    private readonly IPathService                   _pathService;
    private readonly ILogger<GoogleCalendarService> _logger;

    private readonly CalendarService _calendarService;

    private readonly string ApplicationName = "Google Calendar API .NET Quickstart";

    private readonly string[] Scopes =
    {
        CalendarService.Scope.Calendar,
        CalendarService.Scope.CalendarEvents
    };

    public string AddOrUpdate(string eventId, Event evt)
    {
        if (string.IsNullOrWhiteSpace(eventId))
        {
            return InsertEvent(evt);
        }

        var eventIdAtGoogle = _calendarService.Events.Get(CalendarId, eventId)?.EventId;
        if (string.IsNullOrWhiteSpace(eventIdAtGoogle))
        {
            return InsertEvent(evt);
        }

        return UpdateEvent(eventId, evt);
    }

    public void Delete(string eventId)
    {
        var eventIdAtGoogle = _calendarService.Events.Get(CalendarId, eventId)?.EventId;
        if (string.IsNullOrWhiteSpace(eventIdAtGoogle))
        {
            return;
        }

        try
        {
            _calendarService.Events.Delete(CalendarId, eventId).Execute();
        }
        catch (Exception e)
        {
            // 如果發生錯誤，只 Log，不回傳至前端 !

            var errorMessage = e.GetLogMessages();
            _logger.LogError(errorMessage);
        }
    }

    private string InsertEvent(Event evt)
    {
        return _calendarService.Events.Insert(evt, CalendarId)?.Execute()?.Id;
    }

    private string UpdateEvent(string eventId, Event evt)
    {
        return _calendarService.Events.Update(evt, CalendarId, eventId)?.Execute()?.Id;
    }

    private CalendarService GetCalendarService()
    {
        var service = new CalendarService(new BaseClientService.Initializer
                                            {
                                                HttpClientInitializer = GetUserCredential(),
                                                ApplicationName       = ApplicationName
                                            });

        return service;
    }

    private GoogleCredential GetUserCredential()
    {
        var serviceAccountKeyFilePath = new List<string> { _pathService.GetBaseDirectory() }
                                        .Concat(_configuration.GetArray(AppSettingsKey.GoogleServiceAccount))
                                        .ToArray();

        var serviceAccountKeyFile = Path.Combine(serviceAccountKeyFilePath);

        using (var stream = new FileStream(serviceAccountKeyFile, FileMode.Open, FileAccess.Read))
        {
            var credential = GoogleCredential.FromStream(stream)
                                                .CreateScoped(Scopes);

            return credential;
        }
    }
}
```