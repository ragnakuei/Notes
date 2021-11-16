# [Button](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols.button)

- 沒有 runat="server" 的 asp:Button 是沒有任何意義的 !

- 即使指定了 type="button" 在 render 時，還是會被改成 type="submit"

---

## 按下 button 不會 post back 的方式

### 正確解法

加上 **UseSubmitBehavior="false"** 就可以了 !

```html
    <asp:Button
        ID="btn01"
        runat="server"
        UseSubmitBehavior="false"
        type="Button"
        Text="Button01"
        OnClick="btn01Click"
    />
```

### 錯誤解法：還是有可能會先觸發 submit form 的動作

- type="button"
- 加上 attribute OnClientClick 而且回傳 false。如果需要額外執行 js 可加在 return false; 前面。

> 注意：`return false; ` 會阻斷 update panel trigger 的功能 !

    ```html
    <asp:Button
        ID="btn01"
        runat="server"
        type="Button"
        Text="Button01"
        OnClientClick="doSomething(); return false;"
    />
    ```

---

## runat="server" 的 button 必須放在 runat="server" form 中

否則會出現 Exception：`型別 'Button' 的控制項 'btn' 必須置於有 runat=server 的表單標記之中。`

