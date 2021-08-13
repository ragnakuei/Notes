# 註冊 UserControl 的方式

呼叫 UserControl 語法

```html
<VueInitialStyle:VueControl runat="server"/>
```

## 全域

```xml
<system.web>
    <pages>
        <controls>
            <add tagPrefix="VueInitialStyle" tagName="VueControl" src="~/UserControls/VueInitialStyle.ascx" />
        </controls>
    </pages>
</system.web>
```

## 區域

```html
<%@ Register
    Src="~/UserControls/VueInitialStyle.ascx"
    TagPrefix="VueInitialStyle"
    TagName="VueControl" %>
```

## 巢狀

如果要在 UserControl 中，呼叫另一個 UserControl
- 被呼叫的 UserControl 不可以用全域註冊

```html
<%@ Control Language="C#" AutoEventWireup="false" %>

<%@ Register
    Src="~/UserControls/CustomControlB.ascx"
    TagPrefix="CustomControlB"
    TagName="CustomControl" %>


<p>In Custom User Control A</p>
<CustomControlB:CustomControl runat="server" />
```