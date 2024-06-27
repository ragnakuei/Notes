# Server-Sent Event

優點：

-   chrome 發出 request 向後端進行 EventSource 連線時，不會受限於 Request Timeout
-   後端發出 message 的通道，可以支援 custom event，彈性夠
-   語法夠簡單
-   視為 Asp.Net Core SignalR 的極輕量化解決方案

缺點：

-   只能以 Http Get 方式向後端建立連線，如果需要在建立連線時，帶上具有識別性的資料，只能放在 Query String 上 !



##

範例

- [Asp.Net Core MVC](../../.Net/.Net%20or%20.Net%20Core/ASP.NET%20Core/應用/Server-Sent%20Event.md)