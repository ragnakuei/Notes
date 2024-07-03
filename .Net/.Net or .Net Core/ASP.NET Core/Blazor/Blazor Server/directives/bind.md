# [bind](https://docs.microsoft.com/en-us/aspnet/core/blazor/components/data-binding)

參考資料
- [A Detailed Look At Data Binding in Blazor](https://chrissainty.com/a-detailed-look-at-data-binding-in-blazor/)

## input

```html
<p>
    A:<!-- bind 會將資料同步至 field 中 -->
    <input @bind="A" /> 
    => @A
</p>

<p>
    B:<!-- bind 會將資料同步至 property 中 -->
    <input @bind="B" /> 
    => @B
</p>
<p>
    C:    <!-- 
                此效果等同於 B 的結構
                注意：event 是 change 事件
            -->
    <input value="@C"
           @onchange="@((ChangeEventArgs e) => C = e.Value?.ToString())" />
    => @C
</p>
<p>
    D: <!-- 此效果等同於 B 的結構 -->
    <input @bind="D" @bind:event="onchange" />
    => @D
</p>
<p>
    E: <!-- 
                改用 oninpu，立即同步值 
                event 所指定的 action 可不使用 @()
         -->
    <input value="@E"
           @oninput="(ChangeEventArgs e) => E = e.Value?.ToString()" />
    => @E
</p>
<p>
    F: <!-- 改用 oninpu，立即同步值 -->
    <input @bind="F" @bind:event="oninput" />
    => @F
</p>

@code {
    private string? A;

    private string? B { get; set; }

    private string? C { get; set; }
    
    private string? D { get; set; }
    
    private string? E { get; set; }

    private string? F { get; set; }
}
```

## select

### 單選

注意事項:
- 請選擇 Option 值的 binding
  ```html
  <!-- 選擇此項目時，值是 null -->
  <option>請選擇</option>

  <!-- 選擇此項目時，值是 string.Empty -->
  <option value>請選擇</option>
  <option value="">請選擇</option>

  <!-- 選擇此項目時，值是 字串的 null -->
  <option value="null">請選擇</option>
  ```


```html
<p>
    A:
    <input @bind="A" /> <!-- 可以修改這邊的值 & 同步至 Select 中 -->
    <select @bind="A">
        <option>請選擇</option>
        @foreach (var option in Options)
        {
            <option value="@option.Value">@option.Text</option>
        }
    </select>
</p>

@code {
    private string A { get; set; }

    public Option[] Options { get; set; }
    = new[] {
        new Option { Value = "A", Text = "Option A" },
        new Option { Value = "B", Text = "Option B" },
        new Option { Value = "C", Text = "Option C" },
        new Option { Value = "D", Text = "Option D" },
        new Option { Value = "E", Text = "Option E" },
        new Option { Value = "F", Text = "Option F" },
    };


    public class Option
    {
        public string Text { get; set; }
        public string Value { get; set; }
    }
}
```

### 多選

注意事項:
- 不可以動態增刪 Item
- 一定要綁定至 Array\<T>
- 一定要給定初始值


```html
<p>
    A:
    <select @bind="A" multiple>
        @foreach (var option in Options)
        {
            <option value="@option.Value">@option.Text</option>
        }
    </select>
    => @A.ToJson()
</p>


@code {
    private string[] A { get; set; } = Array.Empty<string>();

    public Option[] Options { get; set; }
    = new[] {
        new Option { Value = "A", Text = "Option A" },
        new Option { Value = "B", Text = "Option B" },
        new Option { Value = "C", Text = "Option C" },
        new Option { Value = "D", Text = "Option D" },
        new Option { Value = "E", Text = "Option E" },
        new Option { Value = "F", Text = "Option F" },
    };

    public class Option
    {
        public string Text { get; set; }
        public string Value { get; set; }
    }
}

```

## checkbox

```html

<p>
    @foreach (var option in Options)
    {
        <div>
            <input type="checkbox" name="option" id="@option.Value" value="@option.Value"
                   @onchange="(e) => CheckItemChange(A, Convert.ToBoolean(e.Value), option.Value)" />
            <label for="@option.Value">@option.Text</label>
        </div>
    }
    => @A.ToJson()
</p>


@code {
    private IList<string> A { get; set; } = new List<string>();

    public Option[] Options { get; set; }
    = new[] {
        new Option { Value = "A", Text = "Option A" },
        new Option { Value = "B", Text = "Option B" },
        new Option { Value = "C", Text = "Option C" },
        new Option { Value = "D", Text = "Option D" },
        new Option { Value = "E", Text = "Option E" },
        new Option { Value = "F", Text = "Option F" },
    };

    private void CheckItemChange(IList<string> bindItems, bool isChecked, string value)
    {
        if (isChecked)
        {
            bindItems.Add(value);
        }
        else
        {
            bindItems.Remove(value);
        }
    }

    public class Option
    {
        public string Text { get; set; }
        public string Value { get; set; }
    }
}
```


## radio button


```html

<p>
    @foreach (var option in Options)
    {
        <div>
            <input type="radio" name="option" id="@option.Value" value="@option.Value"
                   checked="@(A == option.Value)" 
                   @onchange="(e) => A = option.Value" />
            <label for="@option.Value">@option.Text</label>
        </div>
    }
    => @A.ToJson()
</p>


@code {
    private string? A { get; set; }

    public Option[] Options { get; set; }
    = new[] {
        new Option { Value = "A", Text = "Option A" },
        new Option { Value = "B", Text = "Option B" },
        new Option { Value = "C", Text = "Option C" },
        new Option { Value = "D", Text = "Option D" },
        new Option { Value = "E", Text = "Option E" },
        new Option { Value = "F", Text = "Option F" },
        };

    public class Option
    {
        public string Text { get; set; }
        public string Value { get; set; }
    }
}
```