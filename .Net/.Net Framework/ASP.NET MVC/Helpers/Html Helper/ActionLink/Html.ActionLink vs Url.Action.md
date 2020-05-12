# Html.ActionLink vs Url.Action

| Razor 語法                                      | 編譯後的語法                                          |
| ----------------------------------------------- | ----------------------------------------------------- |
| @Html.ActionLink("ActionLink", "Index", "List") | \<a href="/List">ActionLink</a>/List                   |
| @Url.Action("Index", "List")                    | Html Tag 與上述相同，但會依照頁面的所在，產生相對路徑 |