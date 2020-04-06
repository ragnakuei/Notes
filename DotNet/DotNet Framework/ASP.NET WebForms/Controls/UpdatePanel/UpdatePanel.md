# [UpdatePanel](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.updatepanel?view=netframework-4.8)

- 一定需要一組 `<asp:ScriptManager>` 不能多，也不能少

- 如果 trigger 綁定了 button click event，那麼會先執行 button click event，再執行 update panel > ContentTemplate 的部份

- Tigger 的 ControlID 及 EventName 可以透過 `asp:UpdatePanel > 屬性 > Triggers` 來設定，以避免 key 錯

- [Understanding Partial Page Updates with ASP.NET AJAX](https://docs.microsoft.com/en-us/aspnet/web-forms/overview/older-versions-getting-started/aspnet-ajax/understanding-partial-page-updates-with-asp-net-ajax)

---

## [UpdateMode](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.updatepanel.updatemode?view=netframework-4.8#System_Web_UI_UpdatePanel_UpdateMode)

| 值          | 功能                                                              |
| ----------- | ----------------------------------------------------------------- |
| Always      | 控制項的內容會針對來自網頁的`所有`回傳而更新。 這包括非同步回傳。 |
| Conditional | 條件更新                                                          |

> Conditional 條件更新的情境
>
> - The `UpdatePanel.Update` method is called explicitly.
> - A control is defined as a trigger by using the `UpdatePanel.Triggers` property and causes a postback. In this scenario, the control is an explicit trigger for updating the panel content. The trigger control can be either inside or outside the UpdatePanel control that defines the trigger.
> - The UpdatePanel.ChildrenAsTriggers property is set to true and a child control of the UpdatePanel control causes a postback. In this scenario, child controls of the UpdatePanel control are implicit triggers for updating the panel. Child controls of nested UpdatePanel controls do not cause the outer UpdatePanel control to be updated unless they are explicitly defined as triggers.

---
