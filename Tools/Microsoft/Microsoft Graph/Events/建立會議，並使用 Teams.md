# 建立會議，並使用 Teams

https://docs.microsoft.com/en-us/graph/api/user-post-events?view=graph-rest-1.0&tabs=http#example-4-create-and-enable-an-event-as-an-online-meeting

只要 request body 給定 isOnlineMeeting: true 就會自動啟用 Teams，並且產生 joinUrl 以及 email body 所需的 meetingInfo !