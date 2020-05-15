# IActionResult

## RedirectToPage

> RedirectToPage(pageName[, routeHandler][, routevalue])

| 名稱         | 說明                                                                  |
| ------------ | --------------------------------------------------------------------- |
| pageName     | 對應 RazorPagesOptions 所給定的 pageName                              |
| routeHandler | 與 asp-page-handler 觀念相同的 handler                                |
| routeValue   | 如果有給定 Route Parameter，要以 anonymous 給定，否則會出現 Exception |

範例

> RedirectToPage("/Order/Detail", new { Id = Id});
